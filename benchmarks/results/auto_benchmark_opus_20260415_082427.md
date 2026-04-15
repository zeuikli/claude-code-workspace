# Auto-Mode Benchmark Report

**Model**: claude-opus-4-6
**Date**: 2026-04-15 16:37

## Summary: Output Token 節省率（vs Baseline）

| Condition | Avg Output Tokens | Avg Input Tokens | Savings vs Baseline |
|-----------|:-----------------:|:----------------:|:-------------------:|
| Baseline (no system prompt) | 1592 | 55 | 0% |
| Caveman Full (session default) | 575 | 948 | 59% |
| Forced Lite (always lite) | 606 | 537 | 58% |
| Forced Ultra (always ultra) | 580 | 543 | 59% |
| Auto Mode (classifier selects) | 565 | 702 | 61% |

## Auto Mode 分類分布

| Level | Count | % |
|-------|:-----:|:-:|
| ultra | 2 | 20% |
| full | 4 | 40% |
| lite | 4 | 40% |

## Auto Mode 逐題分析

| Task | Category | Auto Level | Output Tokens | Savings |
|------|----------|:----------:|:-------------:|:-------:|
| react-rerender | debugging | lite | 208 | 78% |
| auth-middleware-fix | bugfix | ultra | 204 | 82% |
| postgres-pool | setup | lite | 983 | 66% |
| git-rebase-merge | explanation | lite | 550 | 25% |
| async-refactor | refactor | full | 240 | 65% |
| microservices-monolith | architecture | full | 780 | 45% |
| pr-security-review | code-review | lite | 473 | 45% |
| docker-multi-stage | devops | full | 591 | 68% |
| race-condition-debug | debugging | ultra | 519 | 60% |
| error-boundary | implementation | full | 1099 | 73% |

## 逐題跨條件比較

| Task | baseline | full | lite | ultra | auto |
|------|------|------|------|------|------|
| react-rerender | 961t (0%) | 317t (67%) | 207t (78%) | 245t (75%) | 208t (78%) |
| auth-middleware-fix | 1138t (0%) | 204t (82%) | 290t (75%) | 202t (82%) | 204t (82%) |
| postgres-pool | 2854t (0%) | 912t (68%) | 970t (66%) | 936t (67%) | 983t (66%) |
| git-rebase-merge | 729t (0%) | 407t (44%) | 534t (27%) | 376t (48%) | 550t (25%) |
| async-refactor | 694t (0%) | 288t (59%) | 368t (47%) | 225t (68%) | 240t (65%) |
| microservices-monolith | 1417t (0%) | 833t (41%) | 714t (50%) | 844t (40%) | 780t (45%) |
| pr-security-review | 866t (0%) | 656t (24%) | 424t (51%) | 689t (20%) | 473t (45%) |
| docker-multi-stage | 1876t (0%) | 624t (67%) | 620t (67%) | 626t (67%) | 591t (68%) |
| race-condition-debug | 1287t (0%) | 399t (69%) | 574t (55%) | 609t (53%) | 519t (60%) |
| error-boundary | 4096t (0%) | 1108t (73%) | 1364t (67%) | 1048t (74%) | 1099t (73%) |
