# Auto-Mode Benchmark Report

**Model**: claude-haiku-4-5-20251001
**Date**: 2026-04-15 08:06

## Summary: Output Token 節省率（vs Baseline）

| Condition | Avg Output Tokens | Avg Input Tokens | Savings vs Baseline |
|-----------|:-----------------:|:----------------:|:-------------------:|
| Baseline (no system prompt) | 1194 | 54 | 0% |
| Caveman Full (session default) | 476 | 947 | 51% |
| Forced Lite (always lite) | 478 | 536 | 49% |
| Forced Ultra (always ultra) | 467 | 542 | 50% |
| Auto Mode (classifier selects) | 496 | 702 | 45% |

## Auto Mode 分類分布

| Level | Count | % |
|-------|:-----:|:-:|
| ultra | 2 | 20% |
| full | 4 | 40% |
| lite | 4 | 40% |

## Auto Mode 逐題分析

| Task | Category | Auto Level | Output Tokens | Savings |
|------|----------|:----------:|:-------------:|:-------:|
| react-rerender | debugging | lite | 285 | 39% |
| auth-middleware-fix | bugfix | ultra | 286 | 52% |
| postgres-pool | setup | lite | 483 | 76% |
| git-rebase-merge | explanation | lite | 491 | 21% |
| async-refactor | refactor | full | 280 | 31% |
| microservices-monolith | architecture | full | 512 | 0% |
| pr-security-review | code-review | lite | 360 | 38% |
| docker-multi-stage | devops | full | 641 | 63% |
| race-condition-debug | debugging | ultra | 342 | 62% |
| error-boundary | implementation | full | 1278 | 69% |

## 逐題跨條件比較

| Task | baseline | full | lite | ultra | auto |
|------|------|------|------|------|------|
| react-rerender | 471t (0%) | 257t (45%) | 301t (36%) | 314t (33%) | 285t (39%) |
| auth-middleware-fix | 593t (0%) | 211t (64%) | 282t (52%) | 329t (45%) | 286t (52%) |
| postgres-pool | 2010t (0%) | 793t (61%) | 483t (76%) | 472t (77%) | 483t (76%) |
| git-rebase-merge | 624t (0%) | 420t (33%) | 425t (32%) | 436t (30%) | 491t (21%) |
| async-refactor | 408t (0%) | 279t (32%) | 220t (46%) | 234t (43%) | 280t (31%) |
| microservices-monolith | 512t (0%) | 398t (22%) | 417t (19%) | 371t (28%) | 512t (0%) |
| pr-security-review | 576t (0%) | 260t (55%) | 397t (31%) | 367t (36%) | 360t (38%) |
| docker-multi-stage | 1744t (0%) | 618t (65%) | 462t (74%) | 354t (80%) | 641t (63%) |
| race-condition-debug | 907t (0%) | 336t (63%) | 334t (63%) | 323t (64%) | 342t (62%) |
| error-boundary | 4096t (0%) | 1189t (71%) | 1454t (65%) | 1468t (64%) | 1278t (69%) |
