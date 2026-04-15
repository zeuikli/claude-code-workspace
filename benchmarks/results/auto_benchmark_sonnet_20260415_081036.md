# Auto-Mode Benchmark Report

**Model**: claude-sonnet-4-6
**Date**: 2026-04-15 08:21

## Summary: Output Token 節省率（vs Baseline）

| Condition | Avg Output Tokens | Avg Input Tokens | Savings vs Baseline |
|-----------|:-----------------:|:----------------:|:-------------------:|
| Baseline (no system prompt) | 1554 | 55 | 0% |
| Caveman Full (session default) | 683 | 948 | 53% |
| Forced Lite (always lite) | 620 | 537 | 57% |
| Forced Ultra (always ultra) | 556 | 543 | 62% |
| Auto Mode (classifier selects) | 646 | 702 | 56% |

## Auto Mode 分類分布

| Level | Count | % |
|-------|:-----:|:-:|
| ultra | 2 | 20% |
| full | 4 | 40% |
| lite | 4 | 40% |

## Auto Mode 逐題分析

| Task | Category | Auto Level | Output Tokens | Savings |
|------|----------|:----------:|:-------------:|:-------:|
| react-rerender | debugging | lite | 345 | 61% |
| auth-middleware-fix | bugfix | ultra | 240 | 83% |
| postgres-pool | setup | lite | 866 | 56% |
| git-rebase-merge | explanation | lite | 503 | 52% |
| async-refactor | refactor | full | 318 | 44% |
| microservices-monolith | architecture | full | 560 | 62% |
| pr-security-review | code-review | lite | 604 | 18% |
| docker-multi-stage | devops | full | 741 | 69% |
| race-condition-debug | debugging | ultra | 372 | 74% |
| error-boundary | implementation | full | 1910 | 46% |

## 逐題跨條件比較

| Task | baseline | full | lite | ultra | auto |
|------|------|------|------|------|------|
| react-rerender | 895t (0%) | 325t (64%) | 370t (59%) | 309t (65%) | 345t (61%) |
| auth-middleware-fix | 1453t (0%) | 240t (83%) | 312t (79%) | 189t (87%) | 240t (83%) |
| postgres-pool | 1981t (0%) | 987t (50%) | 785t (60%) | 830t (58%) | 866t (56%) |
| git-rebase-merge | 1048t (0%) | 546t (48%) | 564t (46%) | 566t (46%) | 503t (52%) |
| async-refactor | 570t (0%) | 306t (46%) | 210t (63%) | 199t (65%) | 318t (44%) |
| microservices-monolith | 1479t (0%) | 704t (52%) | 507t (66%) | 595t (60%) | 560t (62%) |
| pr-security-review | 735t (0%) | 641t (13%) | 669t (9%) | 612t (17%) | 604t (18%) |
| docker-multi-stage | 2400t (0%) | 606t (75%) | 542t (77%) | 467t (81%) | 741t (69%) |
| race-condition-debug | 1418t (0%) | 736t (48%) | 533t (62%) | 317t (78%) | 372t (74%) |
| error-boundary | 3566t (0%) | 1743t (51%) | 1712t (52%) | 1473t (59%) | 1910t (46%) |
