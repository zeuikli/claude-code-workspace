#!/usr/bin/env python3
"""
Auto-Mode Benchmark：驗證自動壓縮等級選擇的效能
比較 5 種條件：baseline / forced-lite / forced-full / forced-ultra / auto
跨三個模型：Claude Opus 4.6 / Sonnet 4.6（或 4.5）/ Haiku 4.5

使用方式：
  python3 benchmarks/run-auto-benchmark.py                         # 互動輸入 API Key
  ANTHROPIC_API_KEY=sk-... python3 benchmarks/run-auto-benchmark.py
  python3 benchmarks/run-auto-benchmark.py --dry-run               # 不打 API
  python3 benchmarks/run-auto-benchmark.py --trials 1 --models haiku  # 快速 Haiku only
"""

import argparse
import getpass
import hashlib
import json
import os
import re
import statistics
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

# ── 路徑 ─────────────────────────────────────────────────────────────────────
SCRIPT_DIR  = Path(__file__).parent
REPO_DIR    = SCRIPT_DIR.parent
CLAUDE_DIR  = REPO_DIR / '.claude'
RESULTS_DIR = SCRIPT_DIR / 'results'
PROMPTS_FILE = SCRIPT_DIR / 'prompts.json'
SKILL_DIR   = CLAUDE_DIR / 'skills' / 'caveman'

SCRIPT_VERSION = '2.0.0'

# ── 模型設定 ──────────────────────────────────────────────────────────────────
MODELS = {
    'opus':   'claude-opus-4-6',
    'sonnet': 'claude-sonnet-4-6',
    'haiku':  'claude-haiku-4-5-20251001',
}
DEFAULT_MODELS = ['haiku', 'sonnet', 'opus']

# ── System Prompts ────────────────────────────────────────────────────────────
BASELINE_SYSTEM = "You are a helpful assistant."

# 從 caveman SKILL.md 讀取並過濾至指定 level
def load_caveman_system(level: str) -> str:
    skill_path = SKILL_DIR / 'SKILL.md'
    try:
        content = skill_path.read_text()
        # 去除 YAML frontmatter
        if content.startswith('---'):
            parts = content.split('---', 2)
            if len(parts) >= 3:
                content = parts[2].strip()

        if level == 'full':
            return content

        # 過濾 intensity table 和 examples
        lines = content.split('\n')
        filtered = []
        for line in lines:
            table_match = re.match(r'^\|\s*\*\*(\S+?)\*\*\s*\|', line)
            if table_match:
                if table_match.group(1) == level:
                    filtered.append(line)
                continue
            example_match = re.match(r'^- (\S+?):\s', line)
            if example_match:
                if example_match.group(1) == level:
                    filtered.append(line)
                continue
            filtered.append(line)
        return '\n'.join(filtered)
    except FileNotFoundError:
        return BASELINE_SYSTEM


# ── Auto-Classifier（Python 移植版）─────────────────────────────────────────
def classify_prompt(prompt: str) -> str:
    """
    移植自 caveman-auto-classifier.js 的分類邏輯。
    回傳: 'ultra' | 'lite' | 'full'
    """
    raw = prompt.strip()
    words = raw.split()
    wc = len(words)

    # Priority 1: Safety → lite
    safety_patterns = [
        re.compile(r'\b(delete|drop|truncate|rm -rf|destroy|wipe|purge|format|overwrite)\b.*\b(database|table|file|directory|branch|production|prod)\b', re.I),
        re.compile(r'\b(irreversible|cannot undo|permanent|forever)\b', re.I),
        re.compile(r'\b(security|vulnerability|exploit|injection|xss|csrf|credentials|password|secret|token leak)\b', re.I),
    ]
    if any(p.search(raw) for p in safety_patterns):
        return 'lite'

    # Priority 1.5: Fix-how → ultra (before lite's "how do" pattern)
    fix_how_patterns = [
        re.compile(r'\bhow (do i|can i|should i) (fix|debug|troubleshoot|resolve|solve)\b', re.I),
    ]
    if any(p.search(raw) for p in fix_how_patterns):
        return 'ultra'

    # Priority 2: Lite patterns
    lite_patterns = [
        re.compile(r'\b(explain|explanation|understand|understanding|clarify)\b', re.I),
        re.compile(r'\b(why (does|is|do|are|would|should|did)|why (it|this|that))\b', re.I),
        re.compile(r'\b(how does|how do|how would|how should|how can)\b', re.I),
        re.compile(r'\b(teach|guide|tutorial|walkthrough|step.?by.?step|in detail|detailed|elaborate|thoroughly)\b', re.I),
        re.compile(r'\b(document|documentation|readme|write docs?|generate docs?)\b', re.I),
        re.compile(r'\b(architecture|design pattern|system design|high.?level|overview)\b', re.I),
        re.compile(r'\b(compare|comparison|difference between|vs\.?|versus|tradeoff|pros?.?cons?|advantages?|disadvantages?)\b', re.I),
        re.compile(r'\b(best practice|recommendation|should i use|which approach|when to use)\b', re.I),
        re.compile(r'\b(deep dive|comprehensive|thorough|complete guide)\b', re.I),
    ]
    if any(p.search(raw) for p in lite_patterns):
        return 'lite'

    # Priority 2.5: Implementation → full
    impl_patterns = [
        re.compile(r'^(implement|refactor|build|write|design|architect|structure)\b', re.I),
        re.compile(r'^(set up|setup|configure|integrate)\b.{8,}', re.I),
    ]
    if any(p.search(raw) for p in impl_patterns):
        return 'full'

    # Priority 3: Ultra patterns
    ultra_start = [
        re.compile(r'^(fix|check|show|list|run|add|remove|delete|update|get|find|print|log|install|uninstall|enable|disable|restart|start|stop)\b', re.I),
        re.compile(r'^(what is|what\'s|where is|where\'s|is it|does it|can i|should i|which|when|who)\b', re.I),
        re.compile(r'^(convert|rename|move|copy|parse|format|validate|test|lint|build|deploy)\b', re.I),
    ]
    ultra_body = [
        re.compile(r'\b(error|bug|fail|crash|broken|not working|doesn\'?t work|throw|exception|undefined|null pointer|404|500)\b', re.I),
        re.compile(r'\b(syntax error|type error|import error|module not found)\b', re.I),
    ]
    if wc <= 20 and any(p.match(raw) for p in ultra_start):
        return 'ultra'
    if wc < 6:
        return 'ultra'
    if wc <= 30 and any(p.search(raw) for p in ultra_body):
        return 'ultra'

    return 'full'


# ── API 呼叫 ──────────────────────────────────────────────────────────────────
def get_api_key() -> str:
    key = os.environ.get('ANTHROPIC_API_KEY', '').strip()
    if key:
        return key

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

    print('\n請輸入 Anthropic API Key（Enter 確認）：')
    print('（或設定 ANTHROPIC_API_KEY 環境變數）')
    key = getpass.getpass('API Key: ').strip()
    if not key:
        print('ERROR: API Key 不能為空', file=sys.stderr)
        sys.exit(1)
    return key


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
                'text':          response.content[0].text[:300],  # 只存前 300 字元節省空間
                'stop_reason':   response.stop_reason,
            }
        except anthropic.RateLimitError:
            if attempt < max_retries:
                delay = delays[min(attempt, len(delays) - 1)]
                print(f'  Rate limited, retrying in {delay}s...', file=sys.stderr)
                time.sleep(delay)
            else:
                raise


# ── Benchmark 核心 ────────────────────────────────────────────────────────────

CONDITIONS = {
    'baseline': {'system_level': None,    'label': 'Baseline (no system prompt)'},
    'full':     {'system_level': 'full',  'label': 'Caveman Full (session default)'},
    'lite':     {'system_level': 'lite',  'label': 'Forced Lite (always lite)'},
    'ultra':    {'system_level': 'ultra', 'label': 'Forced Ultra (always ultra)'},
    'auto':     {'system_level': 'auto',  'label': 'Auto Mode (classifier selects)'},
}


def run_condition(client, model_id: str, prompts: list, condition: str, trials: int) -> list:
    cond = CONDITIONS[condition]
    results = []

    for i, p in enumerate(prompts, 1):
        entry = {
            'id': p['id'],
            'category': p['category'],
            'prompt': p['prompt'],
            'condition': condition,
            'auto_level': None,
            'trials': [],
        }

        # Auto mode: per-prompt level selection
        if condition == 'auto':
            level = classify_prompt(p['prompt'])
            entry['auto_level'] = level
            system = load_caveman_system(level)
        elif cond['system_level'] is None:
            system = BASELINE_SYSTEM
        else:
            system = load_caveman_system(cond['system_level'])

        for t in range(1, trials + 1):
            auto_tag = f'[auto:{entry["auto_level"]}]' if condition == 'auto' else ''
            print(
                f'  [{i}/{len(prompts)}] {p["id"]} | {condition}{auto_tag} | trial {t}/{trials} | {model_id}',
                file=sys.stderr
            )
            result = call_api(client, model_id, system, p['prompt'])
            entry['trials'].append(result)
            time.sleep(0.5)  # 避免 rate limit

        results.append(entry)
    return results


def compute_stats(all_results: dict) -> dict:
    """
    all_results: { condition: [entry, ...] }
    回傳每個 condition 的統計，以及 auto mode 的分類分布
    """
    # Baseline 作為參照
    baseline = all_results.get('baseline', [])
    baseline_map = {}
    for entry in baseline:
        med = statistics.median([t['output_tokens'] for t in entry['trials']])
        baseline_map[entry['id']] = med

    stats = {}
    for condition, results in all_results.items():
        rows = []
        for entry in results:
            med_out = statistics.median([t['output_tokens'] for t in entry['trials']])
            med_in  = statistics.median([t['input_tokens']  for t in entry['trials']])
            base    = baseline_map.get(entry['id'], med_out)
            savings = round((1 - med_out / base) * 100) if base > 0 else 0

            rows.append({
                'id':           entry['id'],
                'category':     entry['category'],
                'auto_level':   entry.get('auto_level'),
                'median_out':   int(med_out),
                'median_in':    int(med_in),
                'savings_pct':  savings,
            })

        avg_out    = round(statistics.mean([r['median_out']  for r in rows]))
        avg_in     = round(statistics.mean([r['median_in']   for r in rows]))
        avg_sav    = round(statistics.mean([r['savings_pct'] for r in rows]))
        stats[condition] = {
            'rows':     rows,
            'avg_out':  avg_out,
            'avg_in':   avg_in,
            'avg_sav':  avg_sav,
            'label':    CONDITIONS[condition]['label'],
        }

    # Auto mode classifier distribution
    if 'auto' in all_results:
        dist = {'lite': 0, 'full': 0, 'ultra': 0}
        for entry in all_results['auto']:
            lvl = entry.get('auto_level', 'full')
            dist[lvl] = dist.get(lvl, 0) + 1
        stats['auto']['classifier_dist'] = dist

    return stats


def format_report(model_id: str, stats: dict, conditions: list) -> str:
    lines = [f'# Auto-Mode Benchmark Report', f'', f'**Model**: {model_id}', f'**Date**: {datetime.now().strftime("%Y-%m-%d %H:%M")}', '']

    # Summary table
    lines += [
        '## Summary: Output Token 節省率（vs Baseline）',
        '',
        '| Condition | Avg Output Tokens | Avg Input Tokens | Savings vs Baseline |',
        '|-----------|:-----------------:|:----------------:|:-------------------:|',
    ]
    for cond in conditions:
        if cond not in stats:
            continue
        s = stats[cond]
        lines.append(f'| {s["label"]} | {s["avg_out"]} | {s["avg_in"]} | {s["avg_sav"]}% |')
    lines.append('')

    # Auto mode classifier distribution
    if 'auto' in stats and 'classifier_dist' in stats['auto']:
        dist = stats['auto']['classifier_dist']
        total = sum(dist.values())
        lines += [
            '## Auto Mode 分類分布',
            '',
            '| Level | Count | % |',
            '|-------|:-----:|:-:|',
        ]
        for lvl in ['ultra', 'full', 'lite']:
            cnt = dist.get(lvl, 0)
            pct = round(cnt / total * 100) if total > 0 else 0
            lines.append(f'| {lvl} | {cnt} | {pct}% |')
        lines.append('')

    # Per-prompt detail for auto mode
    if 'auto' in stats:
        lines += ['## Auto Mode 逐題分析', '']
        lines += [
            '| Task | Category | Auto Level | Output Tokens | Savings |',
            '|------|----------|:----------:|:-------------:|:-------:|',
        ]
        for r in stats['auto']['rows']:
            lines.append(f'| {r["id"]} | {r["category"]} | {r["auto_level"]} | {r["median_out"]} | {r["savings_pct"]}% |')
        lines.append('')

    # Full comparison across conditions
    lines += ['## 逐題跨條件比較', '']
    if conditions and conditions[0] in stats:
        prompt_ids = [r['id'] for r in stats[conditions[0]]['rows']]
        # Build comparison table
        cond_headers = ' | '.join([f'{c}' for c in conditions if c in stats])
        lines.append(f'| Task | {cond_headers} |')
        lines.append('|------' + '|------' * len([c for c in conditions if c in stats]) + '|')
        for pid in prompt_ids:
            row_parts = []
            for cond in conditions:
                if cond not in stats:
                    continue
                r = next((r for r in stats[cond]['rows'] if r['id'] == pid), None)
                if r:
                    row_parts.append(f'{r["median_out"]}t ({r["savings_pct"]}%)')
                else:
                    row_parts.append('-')
            lines.append(f'| {pid} | ' + ' | '.join(row_parts) + ' |')
        lines.append('')

    return '\n'.join(lines)


def dry_run_show(prompts: list, models: list, conditions: list, trials: int):
    print(f'Models:     {models}')
    print(f'Conditions: {conditions}')
    print(f'Trials:     {trials}')
    print(f'Prompts:    {len(prompts)}')
    total = len(prompts) * len(conditions) * trials * len(models)
    print(f'Est. API calls: {total}')
    print()

    print('Auto-classifier pre-classification:')
    print(f'  {"Prompt":<55} {"Level":<8} Category')
    print('  ' + '-' * 75)
    for p in prompts:
        level = classify_prompt(p['prompt'])
        preview = p['prompt'][:53] + '..' if len(p['prompt']) > 55 else p['prompt']
        print(f'  {preview:<55} {level:<8} {p["category"]}')
    print()

    dist = {}
    for p in prompts:
        lvl = classify_prompt(p['prompt'])
        dist[lvl] = dist.get(lvl, 0) + 1
    print('Classification distribution:', dist)
    print('\nDry run complete. No API calls made.')


# ── Main ──────────────────────────────────────────────────────────────────────
def main():
    parser = argparse.ArgumentParser(description='Auto-mode caveman benchmark across 3 models')
    parser.add_argument('--trials',  type=int, default=2,
                        help='每題每條件執行幾次（預設 2，完整測試用 3）')
    parser.add_argument('--models',  default='all',
                        choices=['all', 'haiku', 'sonnet', 'opus'],
                        help='測試哪些模型（預設 all）')
    parser.add_argument('--conditions', default='all',
                        choices=['all', 'baseline,full,auto', 'auto,ultra,lite'],
                        help='測試哪些條件（預設 all 5 條件）')
    parser.add_argument('--dry-run', action='store_true',
                        help='只顯示設定與分類預測，不打 API')
    args = parser.parse_args()

    # 解析 models
    if args.models == 'all':
        model_keys = DEFAULT_MODELS
    else:
        model_keys = [args.models]

    # 解析 conditions
    if args.conditions == 'all':
        test_conditions = list(CONDITIONS.keys())
    else:
        test_conditions = args.conditions.split(',')

    prompts = json.loads(PROMPTS_FILE.read_text())['prompts']

    if args.dry_run:
        dry_run_show(prompts, model_keys, test_conditions, args.trials)
        return

    api_key = get_api_key()
    os.environ['ANTHROPIC_API_KEY'] = api_key

    try:
        import anthropic
    except ImportError:
        print('ERROR: pip install anthropic', file=sys.stderr)
        sys.exit(1)

    client = anthropic.Anthropic(api_key=api_key)

    RESULTS_DIR.mkdir(parents=True, exist_ok=True)
    ts = datetime.now(timezone.utc).strftime('%Y%m%d_%H%M%S')
    all_model_results = {}

    for model_key in model_keys:
        model_id = MODELS[model_key]
        print(f'\n{"="*60}', file=sys.stderr)
        print(f'Model: {model_id}', file=sys.stderr)
        print(f'Conditions: {test_conditions}  Trials: {args.trials}', file=sys.stderr)
        print(f'{"="*60}', file=sys.stderr)

        model_results = {}
        for cond in test_conditions:
            print(f'\n--- {cond} ({CONDITIONS[cond]["label"]}) ---', file=sys.stderr)
            model_results[cond] = run_condition(client, model_id, prompts, cond, args.trials)

        stats = compute_stats(model_results)
        report = format_report(model_id, stats, test_conditions)
        all_model_results[model_key] = {'stats': stats, 'raw': model_results}

        # 儲存單模型結果
        report_path = RESULTS_DIR / f'auto_benchmark_{model_key}_{ts}.md'
        report_path.write_text(report)
        print(f'\n[{model_key}] Report: {report_path}', file=sys.stderr)
        print(report)

    # 儲存完整 JSON
    json_path = RESULTS_DIR / f'auto_benchmark_{ts}.json'
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump({
            'metadata': {
                'version': SCRIPT_VERSION,
                'date': datetime.now(timezone.utc).isoformat(),
                'models': model_keys,
                'conditions': test_conditions,
                'trials': args.trials,
            },
            'results': {
                mk: {
                    'stats': {
                        cond: {k: v for k, v in s.items() if k != 'rows'}
                        for cond, s in all_model_results[mk]['stats'].items()
                    }
                }
                for mk in all_model_results
            },
        }, f, indent=2, ensure_ascii=False)

    print(f'\nFull JSON: {json_path}', file=sys.stderr)

    # 跨模型摘要
    print('\n' + '='*60)
    print('CROSS-MODEL SUMMARY')
    print('='*60)
    print(f'{"Model":<12} {"Condition":<30} {"Avg Output":<12} {"Savings":<10}')
    print('-' * 65)
    for mk in model_keys:
        for cond in test_conditions:
            s = all_model_results[mk]['stats'].get(cond)
            if s:
                print(f'{mk:<12} {s["label"][:30]:<30} {s["avg_out"]:<12} {s["avg_sav"]}%')
        print()


if __name__ == '__main__':
    main()
