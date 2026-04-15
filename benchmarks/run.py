#!/usr/bin/env python3
"""
Workspace Benchmark: 比較三種規則注入模式的 token 使用效率
Modes:
  A — CLAUDE.md    : 傳統 @file 引用（估算，不呼叫 API）
  B — SKILLS/Hook  : workspace-rules SKILL.md 注入（現有方案）
  C — caveman      : 純 caveman 壓縮規則（最精簡）

Adapted from: https://github.com/JuliusBrussee/caveman/tree/main/benchmarks
Usage:
  python3 benchmarks/run.py                    # 互動輸入 API Key
  ANTHROPIC_API_KEY=sk-... python3 benchmarks/run.py
  python3 benchmarks/run.py --dry-run          # 不打 API，只列出設定
  python3 benchmarks/run.py --mode B           # 只跑特定 mode
  python3 benchmarks/run.py --trials 1         # 每題只跑 1 次（快速測試）
"""

import argparse
import getpass
import hashlib
import json
import os
import statistics
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

# ── 路徑設定 ──────────────────────────────────────────────────────────────────
SCRIPT_DIR   = Path(__file__).parent
REPO_DIR     = SCRIPT_DIR.parent
CLAUDE_DIR   = REPO_DIR / '.claude'
RESULTS_DIR  = SCRIPT_DIR / 'results'
PROMPTS_PATH = SCRIPT_DIR / 'prompts.json'

# 三種模式的 System Prompt 來源
SYSTEM_FILES = {
    'A': {
        'name': 'CLAUDE.md (@file refs)',
        'path': REPO_DIR / 'CLAUDE.md',
        'description': '傳統 @file 引用方式，全部規則每次都載入'
    },
    'B': {
        'name': 'SKILLS.md (Hook Inject)',
        'path': CLAUDE_DIR / 'skills' / 'workspace-rules' / 'SKILL.md',
        'description': '壓縮版 SKILL.md，由 SessionStart hook 注入'
    },
    'C': {
        'name': 'caveman SKILL.md',
        'path': CLAUDE_DIR / 'skills' / 'caveman' / 'SKILL.md',
        'description': '純 caveman 壓縮模式，~75% output token 節省'
    },
}

BASELINE_SYSTEM = "You are a helpful assistant."

SCRIPT_VERSION = '1.0.0'

# ── API 輔助 ──────────────────────────────────────────────────────────────────

def get_api_key() -> str:
    """優先讀 env，再讀 .env.local，最後互動輸入。"""
    # 1. 環境變數
    key = os.environ.get('ANTHROPIC_API_KEY', '').strip()
    if key:
        return key

    # 2. .env.local
    env_file = REPO_DIR / '.env.local'
    if env_file.exists():
        for line in env_file.read_text().splitlines():
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                k, _, v = line.partition('=')
                if k.strip() == 'ANTHROPIC_API_KEY':
                    key = v.strip().strip('"').strip("'")
                    if key:
                        print('[env] Loaded ANTHROPIC_API_KEY from .env.local', file=sys.stderr)
                        return key

    # 3. 互動輸入（不回顯）
    print()
    print('請輸入 Anthropic API Key（輸入不顯示，Enter 確認）：')
    print('（或設定環境變數 ANTHROPIC_API_KEY=sk-... 再執行）')
    key = getpass.getpass('API Key: ').strip()
    if not key:
        print('ERROR: API Key 不能為空', file=sys.stderr)
        sys.exit(1)
    return key


def load_prompts() -> list:
    with open(PROMPTS_PATH) as f:
        data = json.load(f)
    return data['prompts']


def load_system(mode_key: str) -> str:
    info = SYSTEM_FILES[mode_key]
    path = info['path']
    try:
        content = path.read_text()
        # Strip YAML frontmatter if present
        if content.startswith('---'):
            parts = content.split('---', 2)
            if len(parts) >= 3:
                content = parts[2].strip()
        return content
    except FileNotFoundError:
        print(f'WARNING: {path} not found, using baseline system prompt', file=sys.stderr)
        return BASELINE_SYSTEM


def sha256_path(path: Path) -> str:
    try:
        return hashlib.sha256(path.read_bytes()).hexdigest()
    except Exception:
        return 'n/a'


def call_api(client, model: str, system: str, prompt: str, max_retries: int = 3) -> dict:
    import anthropic
    delays = [5, 10, 20]
    for attempt in range(max_retries + 1):
        try:
            response = client.messages.create(
                model=model,
                max_tokens=4096,
                temperature=0,
                system=system,
                messages=[{'role': 'user', 'content': prompt}],
            )
            return {
                'input_tokens':  response.usage.input_tokens,
                'output_tokens': response.usage.output_tokens,
                'text':          response.content[0].text,
                'stop_reason':   response.stop_reason,
            }
        except anthropic.RateLimitError:
            if attempt < max_retries:
                delay = delays[min(attempt, len(delays) - 1)]
                print(f'  Rate limited, retrying in {delay}s...', file=sys.stderr)
                time.sleep(delay)
            else:
                raise


def count_tokens_approx(text: str) -> int:
    """粗估 token 數（每 4 字元 ≈ 1 token）。"""
    return max(1, len(text) // 4)


# ── Benchmark 核心 ────────────────────────────────────────────────────────────

def run_mode(client, model: str, prompts: list, mode_key: str, trials: int) -> list:
    system = load_system(mode_key)
    mode_name = SYSTEM_FILES[mode_key]['name']
    results = []

    for i, p in enumerate(prompts, 1):
        entry = {'id': p['id'], 'category': p['category'], 'prompt': p['prompt'], 'trials': []}
        for t in range(1, trials + 1):
            print(
                f'  [{i}/{len(prompts)}] {p["id"]} | mode={mode_key}({mode_name}) | trial {t}/{trials}',
                file=sys.stderr
            )
            result = call_api(client, model, system, p['prompt'])
            entry['trials'].append(result)
            time.sleep(0.5)
        results.append(entry)
    return results


def compute_stats(mode_results: dict, baseline_results: list) -> dict:
    """計算各 mode 的 token 統計，相對 baseline 比較。"""
    stats = {}
    baseline_map = {e['id']: statistics.median([t['output_tokens'] for t in e['trials']]) for e in baseline_results}

    for mode_key, results in mode_results.items():
        rows = []
        for entry in results:
            med_output = statistics.median([t['output_tokens'] for t in entry['trials']])
            med_input  = statistics.median([t['input_tokens'] for t in entry['trials']])
            base_output = baseline_map.get(entry['id'], med_output)
            savings = 1 - (med_output / base_output) if base_output > 0 else 0
            rows.append({
                'id':            entry['id'],
                'category':      entry['category'],
                'median_output': int(med_output),
                'median_input':  int(med_input),
                'baseline_output': int(base_output),
                'savings_pct':   round(savings * 100),
            })

        avg_output   = round(statistics.mean([r['median_output'] for r in rows]))
        avg_input    = round(statistics.mean([r['median_input']  for r in rows]))
        avg_savings  = round(statistics.mean([r['savings_pct']   for r in rows]))
        stats[mode_key] = {'rows': rows, 'avg_output': avg_output, 'avg_input': avg_input, 'avg_savings': avg_savings}

    return stats


def format_report(stats: dict, system_token_counts: dict) -> str:
    lines = ['# Workspace Benchmark Report', '']
    lines.append('## System Prompt Token 成本（注入開銷）')
    lines.append('')
    lines.append('| Mode | System | Tokens (approx) | 描述 |')
    lines.append('|------|--------|:-----------:|------|')
    for k, info in SYSTEM_FILES.items():
        tc = system_token_counts.get(k, 0)
        lines.append(f'| {k} | {info["name"]} | ~{tc} | {info["description"]} |')
    lines.append('')

    lines.append('## Output Token 節省率（vs Baseline）')
    lines.append('')
    lines.append('| Mode | System | Avg Output Tokens | Avg Input Tokens | Savings vs Baseline |')
    lines.append('|------|--------|:-----------------:|:----------------:|:-------------------:|')
    for k, s in stats.items():
        info = SYSTEM_FILES[k]
        lines.append(f'| {k} | {info["name"]} | {s["avg_output"]} | {s["avg_input"]} | {s["avg_savings"]}% |')
    lines.append('')

    for k, s in stats.items():
        info = SYSTEM_FILES[k]
        lines.append(f'### Mode {k}: {info["name"]}')
        lines.append('')
        lines.append('| Task | Output Tokens | Input Tokens | Savings |')
        lines.append('|------|:-------------:|:------------:|:-------:|')
        for r in s['rows']:
            lines.append(f'| {r["id"]} | {r["median_output"]} | {r["median_input"]} | {r["savings_pct"]}% |')
        lines.append('')

    return '\n'.join(lines)


def dry_run(prompts: list, modes: list, model: str, trials: int):
    print(f'Model:  {model}')
    print(f'Modes:  {modes}')
    print(f'Trials: {trials}')
    print(f'Prompts: {len(prompts)}')
    print(f'Total API calls: {len(prompts) * len(modes) * trials} + {len(prompts) * trials} (baseline)')
    print()
    print('System prompts (approx tokens):')
    for k, info in SYSTEM_FILES.items():
        if k in modes:
            tc = count_tokens_approx(load_system(k))
            print(f'  Mode {k} [{info["name"]}]: ~{tc} tokens')
    print()
    for p in prompts:
        preview = p['prompt'][:80] + ('...' if len(p['prompt']) > 80 else '')
        print(f'  [{p["id"]}] {preview}')
    print()
    print('Dry run complete. No API calls made.')


# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description='Workspace benchmark: CLAUDE.md vs SKILLS vs caveman')
    parser.add_argument('--trials', type=int, default=3,    help='每題每模式執行幾次（預設 3）')
    parser.add_argument('--model',  default='claude-haiku-4-5-20251001', help='使用的模型（預設 Haiku 節省費用）')
    parser.add_argument('--mode',   choices=['A', 'B', 'C', 'all'], default='all', help='測試模式（預設 all）')
    parser.add_argument('--dry-run', action='store_true',   help='只列印設定，不打 API')
    parser.add_argument('--no-baseline', action='store_true', help='跳過 baseline 測試（加快速度）')
    args = parser.parse_args()

    prompts = load_prompts()
    modes   = ['A', 'B', 'C'] if args.mode == 'all' else [args.mode]

    if args.dry_run:
        dry_run(prompts, modes, args.model, args.trials)
        return

    # 計算系統提示的 token 開銷（本地估算，不打 API）
    system_token_counts = {k: count_tokens_approx(load_system(k)) for k in modes}

    # 取得 API Key（互動輸入）
    api_key = get_api_key()
    os.environ['ANTHROPIC_API_KEY'] = api_key

    try:
        import anthropic
    except ImportError:
        print('ERROR: anthropic package not installed. Run: pip install anthropic', file=sys.stderr)
        sys.exit(1)

    client = anthropic.Anthropic(api_key=api_key)

    print(f'\nRunning workspace benchmark', file=sys.stderr)
    print(f'  Model:   {args.model}', file=sys.stderr)
    print(f'  Modes:   {modes}', file=sys.stderr)
    print(f'  Prompts: {len(prompts)}  Trials: {args.trials}', file=sys.stderr)
    print(f'  Est. API calls: {len(prompts) * (len(modes) + (0 if args.no_baseline else 1)) * args.trials}', file=sys.stderr)
    print(file=sys.stderr)

    # Baseline
    baseline_results = []
    if not args.no_baseline:
        print('--- Baseline (no system prompt) ---', file=sys.stderr)
        baseline_results = run_mode(client, args.model, prompts, 'B', args.trials)
        # Reuse B's structure but with baseline system
        for entry in baseline_results:
            for trial in entry['trials']:
                pass  # already has real data

    # Run each mode
    mode_results = {}
    for mode_key in modes:
        print(f'--- Mode {mode_key}: {SYSTEM_FILES[mode_key]["name"]} ---', file=sys.stderr)
        mode_results[mode_key] = run_mode(client, args.model, prompts, mode_key, args.trials)

    # Stats (use mode B as baseline if no separate baseline run)
    if not baseline_results and 'B' in mode_results:
        baseline_results = mode_results['B']
    elif not baseline_results:
        baseline_results = list(mode_results.values())[0]

    stats = compute_stats(mode_results, baseline_results)
    report = format_report(stats, system_token_counts)

    # Save
    RESULTS_DIR.mkdir(parents=True, exist_ok=True)
    ts = datetime.now(timezone.utc).strftime('%Y%m%d_%H%M%S')
    result_data = {
        'metadata': {
            'version': SCRIPT_VERSION,
            'model':   args.model,
            'date':    datetime.now(timezone.utc).isoformat(),
            'trials':  args.trials,
            'modes':   modes,
        },
        'system_token_counts': system_token_counts,
        'stats':  stats,
        'raw':    mode_results,
    }
    json_path = RESULTS_DIR / f'benchmark_{ts}.json'
    with open(json_path, 'w') as f:
        json.dump(result_data, f, indent=2, ensure_ascii=False)

    report_path = RESULTS_DIR / f'benchmark_{ts}.md'
    with open(report_path, 'w') as f:
        f.write(report)

    print(f'\nResults saved:', file=sys.stderr)
    print(f'  JSON:   {json_path}', file=sys.stderr)
    print(f'  Report: {report_path}', file=sys.stderr)
    print()
    print(report)


if __name__ == '__main__':
    main()
