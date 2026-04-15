# Auto-Mode Benchmark Report

**Model**: claude-sonnet-4-6
**Date**: 2026-04-15 16:27

## Summary: Output Token 節省率（vs Baseline）

| Condition | Avg Output Tokens | Avg Input Tokens | Savings vs Baseline |
|-----------|:-----------------:|:----------------:|:-------------------:|
| Baseline (no system prompt) | 1567 | 55 | 0% |
| Caveman Full (session default) | 683 | 948 | 55% |
| Forced Lite (always lite) | 676 | 537 | 56% |
| Forced Ultra (always ultra) | 576 | 543 | 60% |
| Auto Mode (classifier selects) | 661 | 702 | 57% |

## Auto Mode 分類分布

| Level | Count | % |
|-------|:-----:|:-:|
| ultra | 2 | 20% |
| full | 4 | 40% |
| lite | 4 | 40% |

## Auto Mode 逐題分析

| Task | Category | Auto Level | Output Tokens | Savings |
|------|----------|:----------:|:-------------:|:-------:|
| react-rerender | debugging | lite | 327 | 62% |
| auth-middleware-fix | bugfix | ultra | 279 | 73% |
| postgres-pool | setup | lite | 975 | 51% |
| git-rebase-merge | explanation | lite | 490 | 46% |
| async-refactor | refactor | full | 306 | 40% |
| microservices-monolith | architecture | full | 536 | 62% |
| pr-security-review | code-review | lite | 595 | 39% |
| docker-multi-stage | devops | full | 733 | 74% |
| race-condition-debug | debugging | ultra | 317 | 75% |
| error-boundary | implementation | full | 2049 | 46% |

## 逐題跨條件比較

| Task | baseline | full | lite | ultra | auto |
|------|------|------|------|------|------|
| react-rerender | 862t (0%) | 313t (64%) | 335t (61%) | 247t (71%) | 327t (62%) |
| auth-middleware-fix | 1049t (0%) | 336t (68%) | 318t (70%) | 281t (73%) | 279t (73%) |
| postgres-pool | 2005t (0%) | 959t (52%) | 951t (53%) | 817t (59%) | 975t (51%) |
| git-rebase-merge | 909t (0%) | 516t (43%) | 517t (43%) | 542t (40%) | 490t (46%) |
| async-refactor | 510t (0%) | 268t (47%) | 200t (61%) | 222t (56%) | 306t (40%) |
| microservices-monolith | 1425t (0%) | 499t (65%) | 444t (69%) | 441t (69%) | 536t (62%) |
| pr-security-review | 978t (0%) | 712t (27%) | 638t (35%) | 742t (24%) | 595t (39%) |
| docker-multi-stage | 2856t (0%) | 785t (73%) | 538t (81%) | 545t (81%) | 733t (74%) |
| race-condition-debug | 1273t (0%) | 477t (63%) | 763t (40%) | 432t (66%) | 317t (75%) |
| error-boundary | 3806t (0%) | 1966t (48%) | 2052t (46%) | 1496t (61%) | 2049t (46%) |
