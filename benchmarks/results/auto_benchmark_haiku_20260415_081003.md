# Auto-Mode Benchmark Report

**Model**: claude-haiku-4-5-20251001
**Date**: 2026-04-15 16:14

## Summary: Output Token 節省率（vs Baseline）

| Condition | Avg Output Tokens | Avg Input Tokens | Savings vs Baseline |
|-----------|:-----------------:|:----------------:|:-------------------:|
| Baseline (no system prompt) | 1163 | 54 | 0% |
| Caveman Full (session default) | 469 | 947 | 52% |
| Forced Lite (always lite) | 481 | 536 | 49% |
| Forced Ultra (always ultra) | 433 | 542 | 52% |
| Auto Mode (classifier selects) | 476 | 702 | 50% |

## Auto Mode 分類分布

| Level | Count | % |
|-------|:-----:|:-:|
| ultra | 2 | 20% |
| full | 4 | 40% |
| lite | 4 | 40% |

## Auto Mode 逐題分析

| Task | Category | Auto Level | Output Tokens | Savings |
|------|----------|:----------:|:-------------:|:-------:|
| react-rerender | debugging | lite | 232 | 52% |
| auth-middleware-fix | bugfix | ultra | 240 | 61% |
| postgres-pool | setup | lite | 477 | 71% |
| git-rebase-merge | explanation | lite | 494 | 16% |
| async-refactor | refactor | full | 279 | 32% |
| microservices-monolith | architecture | full | 451 | 35% |
| pr-security-review | code-review | lite | 397 | 31% |
| docker-multi-stage | devops | full | 493 | 71% |
| race-condition-debug | debugging | ultra | 328 | 65% |
| error-boundary | implementation | full | 1367 | 66% |

## 逐題跨條件比較

| Task | baseline | full | lite | ultra | auto |
|------|------|------|------|------|------|
| react-rerender | 483t (0%) | 268t (45%) | 278t (42%) | 317t (34%) | 232t (52%) |
| auth-middleware-fix | 619t (0%) | 219t (65%) | 263t (58%) | 240t (61%) | 240t (61%) |
| postgres-pool | 1619t (0%) | 793t (51%) | 483t (70%) | 468t (71%) | 477t (71%) |
| git-rebase-merge | 591t (0%) | 441t (25%) | 491t (17%) | 404t (32%) | 494t (16%) |
| async-refactor | 408t (0%) | 279t (32%) | 211t (48%) | 264t (35%) | 279t (32%) |
| microservices-monolith | 692t (0%) | 426t (38%) | 382t (45%) | 421t (39%) | 451t (35%) |
| pr-security-review | 576t (0%) | 245t (57%) | 547t (5%) | 377t (35%) | 397t (31%) |
| docker-multi-stage | 1702t (0%) | 453t (73%) | 408t (76%) | 457t (73%) | 493t (71%) |
| race-condition-debug | 928t (0%) | 336t (64%) | 300t (68%) | 321t (65%) | 328t (65%) |
| error-boundary | 4009t (0%) | 1229t (69%) | 1446t (64%) | 1064t (73%) | 1367t (66%) |
