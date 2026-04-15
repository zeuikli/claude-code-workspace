#!/usr/bin/env python3
"""
Workspace Injection Mode Benchmark
===================================
比較三種 Claude Code 規則注入模式的 Token 消耗：

  Mode A — CLAUDE.md   : 完整 CLAUDE.md + 所有 rules/*.md（目前作法）
  Mode B — SKILL.md    : 壓縮後的 SKILL.md（caveman hook 注入）
  Mode C — Selective   : 僅最小核心規則（SKILL-rules-only.md）

使用與 caveman benchmark 相同的 10 道提示題，
並額外加入 4 道 workspace 特有情境題。

依賴：pip install anthropic tiktoken
API Key：ANTHROPIC_API_KEY 環境變數

用法：
  python3 benchmarks/benchmark-injection-modes.py
  python3 benchmarks/benchmark-injection-modes.py --dry-run
  python3 benchmarks/benchmark-injection-modes.py --trials 1 --model claude-haiku-4-5-20251001
"""

import argparse
import json
import os
import statistics
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

import anthropic
import tiktoken

# ── 路徑設定 ─────────────────────────────────────────────────────────────────

REPO_DIR      = Path(__file__).parent.parent
BENCHMARK_DIR = Path(__file__).parent
RESULTS_DIR   = BENCHMARK_DIR / "results"
PROMPTS_FILE  = BENCHMARK_DIR / "prompts.json"          # caveman 的 10 題
WS_PROMPTS_FILE = BENCHMARK_DIR / "prompts-workspace.json"  # workspace 特有題

CLAUDE_MD_PATH   = REPO_DIR / "CLAUDE.md"
RULES_DIR        = REPO_DIR / ".claude" / "rules"
SKILL_FULL_PATH  = REPO_DIR / ".claude" / "skills" / "workspace-rules" / "SKILL.md"
SKILL_MIN_PATH   = REPO_DIR / ".claude" / "skills" / "workspace-rules" / "SKILL-rules-only.md"

# ── Token 計數 ────────────────────────────────────────────────────────────────

_enc = tiktoken.get_encoding("cl100k_base")  # 近似 Claude tokenizer

def count_tokens(text: str) -> int:
    return len(_enc.encode(text))


# ── 系統 Prompt 載入（三種模式）─────────────────────────────────────────────

def load_mode_a_claudemd() -> str:
    """Mode A: 完整 CLAUDE.md + 所有 rules/*.md（目前 session 真實載入量）"""
    parts = [CLAUDE_MD_PATH.read_text()]
    for rule_file in sorted(RULES_DIR.glob("*.md")):
        parts.append(rule_file.read_text())
    return "\n\n---\n\n".join(parts)


def load_mode_b_skill() -> str:
    """Mode B: 壓縮 SKILL.md（去除 YAML frontmatter）"""
    raw = SKILL_FULL_PATH.read_text()
    body = raw.split("---", 2)[-1].strip() if raw.startswith("---") else raw
    return f"[workspace-inject] mode=full\n\n{body}"


def load_mode_c_selective() -> str:
    """Mode C: 最小核心規則（SKILL-rules-only.md）"""
    raw = SKILL_MIN_PATH.read_text()
    body = raw.split("---", 2)[-1].strip() if raw.startswith("---") else raw
    return f"[workspace-inject] mode=selective\n\n{body}"


MODES = {
    "A_claude_md":  {"label": "CLAUDE.md (全量)",   "loader": load_mode_a_claudemd},
    "B_skill_full": {"label": "SKILL.md (壓縮)",    "loader": load_mode_b_skill},
    "C_selective":  {"label": "Rules.md (精選)",    "loader": load_mode_c_selective},
}


# ── Prompt 載入 ───────────────────────────────────────────────────────────────

def load_all_prompts() -> list[dict]:
    prompts = []
    # caveman 標準 10 題
    with open(PROMPTS_FILE) as f:
        data = json.load(f)
    prompts.extend(data["prompts"])
    # workspace 特有題（若存在）
    if WS_PROMPTS_FILE.exists():
        with open(WS_PROMPTS_FILE) as f:
            ws = json.load(f)
        prompts.extend(ws.get("prompts", []))
    return prompts


# ── API 呼叫 ──────────────────────────────────────────────────────────────────

def call_api(client: anthropic.Anthropic, model: str, system: str, prompt: str,
             max_retries: int = 3) -> dict:
    delays = [5, 10, 20]
    for attempt in range(max_retries + 1):
        try:
            response = client.messages.create(
                model=model,
                max_tokens=2048,
                temperature=0,
                system=system,
                messages=[{"role": "user", "content": prompt}],
            )
            return {
                "input_tokens":  response.usage.input_tokens,
                "output_tokens": response.usage.output_tokens,
                "text":          response.content[0].text,
                "stop_reason":   response.stop_reason,
            }
        except anthropic.RateLimitError:
            if attempt < max_retries:
                d = delays[min(attempt, len(delays) - 1)]
                print(f"  Rate limited, retry in {d}s…", file=sys.stderr)
                time.sleep(d)
            else:
                raise
        except anthropic.APIError as e:
            print(f"  API error: {e}", file=sys.stderr)
            if attempt < max_retries:
                time.sleep(delays[0])
            else:
                raise


# ── 核心執行 ──────────────────────────────────────────────────────────────────

def run_benchmark(client: anthropic.Anthropic, model: str,
                  prompts: list[dict], trials: int) -> dict:
    """
    回傳結構：
    {
        "mode_id": {
            "system_tokens": int,          # 系統 prompt token 數（不含使用者 prompt）
            "results": [
                {
                    "prompt_id": str,
                    "input_tokens_median":  int,  # API 回報（含系統）
                    "output_tokens_median": int,
                    "raw_trials": [...]
                }
            ]
        }
    }
    """
    data = {}

    for mode_id, mode_cfg in MODES.items():
        system_prompt = mode_cfg["loader"]()
        sys_tokens = count_tokens(system_prompt)
        print(f"\n[MODE {mode_id}] {mode_cfg['label']} — system={sys_tokens} tokens",
              file=sys.stderr)
        data[mode_id] = {"system_tokens": sys_tokens, "results": []}

        for p in prompts:
            pid   = p["id"]
            ptext = p["prompt"]
            trials_data = []

            for t in range(1, trials + 1):
                print(f"  prompt={pid} trial={t}/{trials}", file=sys.stderr)
                result = call_api(client, model, system_prompt, ptext)
                trials_data.append(result)
                time.sleep(0.3)

            input_med  = int(statistics.median([r["input_tokens"]  for r in trials_data]))
            output_med = int(statistics.median([r["output_tokens"] for r in trials_data]))

            data[mode_id]["results"].append({
                "prompt_id":             pid,
                "category":              p.get("category", ""),
                "input_tokens_median":   input_med,
                "output_tokens_median":  output_med,
                "raw_trials":            trials_data,
            })

    return data


# ── 報告生成 ──────────────────────────────────────────────────────────────────

def compute_summary(data: dict) -> dict:
    summary = {}
    for mode_id, mode_data in data.items():
        out_tokens = [r["output_tokens_median"] for r in mode_data["results"]]
        inp_tokens = [r["input_tokens_median"]  for r in mode_data["results"]]
        summary[mode_id] = {
            "system_tokens":        mode_data["system_tokens"],
            "avg_output_tokens":    int(statistics.mean(out_tokens)),
            "avg_total_input":      int(statistics.mean(inp_tokens)),
            "total_output_all":     sum(out_tokens),
        }
    return summary


def print_report(data: dict, summary: dict, prompts: list[dict]):
    mode_ids = list(MODES.keys())
    labels   = {k: MODES[k]["label"] for k in mode_ids}

    print("\n" + "=" * 80)
    print("  WORKSPACE INJECTION MODE BENCHMARK")
    print("=" * 80)

    # ── 系統 Prompt Token 比較 ────────────────────────────────────────────────
    print("\n【系統 Prompt Token 消耗（每 session 固定成本）】\n")
    baseline = summary[mode_ids[0]]["system_tokens"]
    for mode_id in mode_ids:
        sys_tok = summary[mode_id]["system_tokens"]
        saved   = baseline - sys_tok
        pct     = round((1 - sys_tok / baseline) * 100) if baseline else 0
        bar     = "▓" * int(sys_tok / 20)
        print(f"  {labels[mode_id]:<20} {sys_tok:>5} tokens  {bar}")
        if saved > 0:
            print(f"  {'':20} vs Mode A: -{saved} ({pct}% 節省)")
    print()

    # ── 每題 Output Token 比較 ────────────────────────────────────────────────
    print("【各題 Output Token（模型回應長度）】\n")
    header = f"{'Prompt ID':<28}" + "".join(f"{labels[m]:<22}" for m in mode_ids)
    print("  " + header)
    print("  " + "-" * len(header))

    all_rows = {m: [] for m in mode_ids}
    for i, p in enumerate(prompts):
        pid = p["id"]
        row = f"  {pid:<28}"
        for mode_id in mode_ids:
            results = data[mode_id]["results"]
            match = next((r for r in results if r["prompt_id"] == pid), None)
            tok = match["output_tokens_median"] if match else 0
            all_rows[mode_id].append(tok)
            row += f"{tok:<22}"
        print(row)

    print("  " + "-" * len(header))
    avg_row = f"  {'Average':<28}"
    for mode_id in mode_ids:
        avg = int(statistics.mean(all_rows[mode_id])) if all_rows[mode_id] else 0
        avg_row += f"{avg:<22}"
    print(avg_row)
    print()

    # ── 綜合建議 ─────────────────────────────────────────────────────────────
    print("【綜合建議】\n")
    sys_toks = {m: summary[m]["system_tokens"] for m in mode_ids}
    out_avgs  = {m: summary[m]["avg_output_tokens"] for m in mode_ids}

    best_sys = min(mode_ids, key=lambda m: sys_toks[m])
    best_out = min(mode_ids, key=lambda m: out_avgs[m])

    print(f"  最省 Input（系統 prompt）：{labels[best_sys]} ({sys_toks[best_sys]} tokens)")
    print(f"  最省 Output（模型回應）  ：{labels[best_out]} ({out_avgs[best_out]} tokens avg)")

    # 估算 100 session 成本
    print("\n  100 session 累積 Input Token 估算（系統 prompt × 100 + 10 題 output × 100）：")
    for mode_id in mode_ids:
        total = sys_toks[mode_id] * 100 + summary[mode_id]["total_output_all"] * 10
        a_total = sys_toks[mode_ids[0]] * 100 + summary[mode_ids[0]]["total_output_all"] * 10
        pct = round((1 - total / a_total) * 100) if a_total else 0
        print(f"    {labels[mode_id]:<20} {total:>8,} tokens"
              + (f"  (-{pct}% vs Mode A)" if pct > 0 else " (baseline)"))
    print()


def save_results(data: dict, summary: dict, model: str, trials: int):
    RESULTS_DIR.mkdir(parents=True, exist_ok=True)
    ts = datetime.now(timezone.utc).strftime("%Y%m%d_%H%M%S")
    out = {
        "metadata": {
            "script":    "benchmark-injection-modes.py",
            "model":     model,
            "date":      datetime.now(timezone.utc).isoformat(),
            "trials":    trials,
            "modes":     {k: MODES[k]["label"] for k in MODES},
        },
        "summary": summary,
        "raw": data,
    }
    p = RESULTS_DIR / f"injection_modes_{ts}.json"
    with open(p, "w") as f:
        json.dump(out, f, indent=2, ensure_ascii=False)
    return p


# ── Dry Run ───────────────────────────────────────────────────────────────────

def dry_run(prompts: list[dict], model: str, trials: int):
    print(f"Model:        {model}")
    print(f"Trials:       {trials}")
    print(f"Prompts:      {len(prompts)}")
    print(f"Modes:        {len(MODES)}")
    print(f"Total calls:  {len(prompts) * len(MODES) * trials}\n")
    print("System prompt token counts (tiktoken cl100k_base approx):")
    for mode_id, cfg in MODES.items():
        sys_p = cfg["loader"]()
        print(f"  {cfg['label']:<22} {count_tokens(sys_p):>5} tokens")
    print("\nPrompts:")
    for p in prompts:
        print(f"  [{p['id']}] {p['prompt'][:70]}...")
    print("\nDry run done. No API calls.")


# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(
        description="Compare CLAUDE.md vs SKILL.md vs Selective injection modes")
    parser.add_argument("--trials", type=int, default=2,
                        help="API calls per prompt per mode (default: 2)")
    parser.add_argument("--dry-run", action="store_true",
                        help="Count tokens only, no API calls")
    parser.add_argument("--model", default="claude-haiku-4-5-20251001",
                        help="Model to use (default: claude-haiku-4-5-20251001)")
    args = parser.parse_args()

    prompts = load_all_prompts()

    if args.dry_run:
        dry_run(prompts, args.model, args.trials)
        return

    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        print("ERROR: ANTHROPIC_API_KEY not set", file=sys.stderr)
        sys.exit(1)

    client = anthropic.Anthropic(api_key=api_key)

    print(f"Benchmark: {len(prompts)} prompts × {len(MODES)} modes × {args.trials} trials",
          file=sys.stderr)
    print(f"Model: {args.model}", file=sys.stderr)

    data    = run_benchmark(client, args.model, prompts, args.trials)
    summary = compute_summary(data)
    print_report(data, summary, prompts)
    path    = save_results(data, summary, args.model, args.trials)
    print(f"Results saved → {path}", file=sys.stderr)


if __name__ == "__main__":
    main()
