# Auto-Mode Benchmark Report

**Model**: claude-opus-4-6
**Date**: 2026-04-15 08:34

## Summary: Output Token 節省率（vs Baseline）

| Condition | Avg Output Tokens | Avg Input Tokens | Savings vs Baseline |
|-----------|:-----------------:|:----------------:|:-------------------:|
| Baseline (no system prompt) | 1600 | 55 | 0% |
| Caveman Full (session default) | 609 | 948 | 59% |
| Forced Lite (always lite) | 605 | 537 | 59% |
| Forced Ultra (always ultra) | 587 | 543 | 61% |
| Auto Mode (classifier selects) | 595 | 702 | 60% |

## Auto Mode 分類分布

| Level | Count | % |
|-------|:-----:|:-:|
| ultra | 2 | 20% |
| full | 4 | 40% |
| lite | 4 | 40% |

## Auto Mode 逐題分析

| Task | Category | Auto Level | Output Tokens | Savings |
|------|----------|:----------:|:-------------:|:-------:|
| react-rerender | debugging | lite | 273 | 73% |
| auth-middleware-fix | bugfix | ultra | 204 | 79% |
| postgres-pool | setup | lite | 1035 | 64% |
| git-rebase-merge | explanation | lite | 505 | 29% |
| async-refactor | refactor | full | 233 | 70% |
| microservices-monolith | architecture | full | 843 | 38% |
| pr-security-review | code-review | lite | 473 | 60% |
| docker-multi-stage | devops | full | 712 | 60% |
| race-condition-debug | debugging | ultra | 524 | 60% |
| error-boundary | implementation | full | 1146 | 72% |

## 逐題跨條件比較

| Task | baseline | full | lite | ultra | auto |
|------|------|------|------|------|------|
| react-rerender | 1005t (0%) | 333t (67%) | 302t (70%) | 245t (76%) | 273t (73%) |
| auth-middleware-fix | 956t (0%) | 186t (81%) | 199t (79%) | 202t (79%) | 204t (79%) |
| postgres-pool | 2854t (0%) | 950t (67%) | 950t (67%) | 947t (67%) | 1035t (64%) |
| git-rebase-merge | 713t (0%) | 480t (33%) | 507t (29%) | 418t (41%) | 505t (29%) |
| async-refactor | 778t (0%) | 242t (69%) | 372t (52%) | 304t (61%) | 233t (70%) |
| microservices-monolith | 1364t (0%) | 812t (40%) | 810t (41%) | 836t (39%) | 843t (38%) |
| pr-security-review | 1175t (0%) | 707t (40%) | 443t (62%) | 579t (51%) | 473t (60%) |
| docker-multi-stage | 1762t (0%) | 718t (59%) | 588t (67%) | 590t (67%) | 712t (60%) |
| race-condition-debug | 1295t (0%) | 519t (60%) | 534t (59%) | 522t (60%) | 524t (60%) |
| error-boundary | 4096t (0%) | 1146t (72%) | 1347t (67%) | 1228t (70%) | 1146t (72%) |
