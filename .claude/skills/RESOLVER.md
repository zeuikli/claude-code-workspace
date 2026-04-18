# Skill Resolver

觸發詞到技能的路由表。改 SKILL.md 的適用範圍時，同步更新這裡。

> **動手前先讀 SKILL.md。** 兩個技能都可能匹配時，兩個都讀 — 許多技能設計成可串聯。

## 按工作流階段分路

### Pre-build（動手前）

| 觸發詞 | 技能 |
|--------|------|
| 新功能 / 架構決策 / 「怎麼設計」/ 「應該用什麼方案」 | `think`（waza） |
| UI / 前端 / 視覺設計 / 「避免 AI slop」 | `frontend-design` |
| 需求釐清 / 使用者訪談 / 功能規格 | `spec-interview` |
| 行銷文案 / SEO / Landing page | `marketing` |
| Sprint 規劃 / PM 多 Agent 協作 | `pm` |

### Post-build（交付前）

| 觸發詞 | 技能 |
|--------|------|
| 實作完成 / 合併前 / commit 前審查 / 「review 一下」 | `deep-review` |
| Diff 詳細審查 / 安全 + 架構 specialist | `check`（waza） |

### Diagnostic（出問題了）

| 觸發詞 | 技能 |
|--------|------|
| 報錯 / 崩潰 / 測試失敗 / 「為什麼不 work」 | `hunt`（waza）/ `debug` |
| Claude 忽略指令 / hook 失靈 / MCP 異常 / 配置稽核 | `health`（waza） |
| 效能瓶頸 / 執行太慢 / benchmark | `perf` |

### Research & Content（研究與內容）

| 觸發詞 | 技能 |
|--------|------|
| 深度研究陌生領域 / 六階段研究到成稿 | `learn`（waza） |
| 研究 Claude Code 功能 / Anthropic API 最佳實踐 | `research-best-practices` |
| 一般研究 / 技術調查 | `research` |
| 文章寫作 / 去 AI 味 / 潤稿 | `writing` |

### Workspace 管理

| 觸發詞 | 技能 |
|--------|------|
| 「workspace 有什麼 skill」/ 「怎麼載入」/ token 估算 | `load-plan` |
| Codebase 架構圖 / 模組依賴視覺化 | `map` |
| 新增 skill / agent / tool 設計 | `add-skill` |
| 成本追蹤 / API usage | `cost-tracker` |
| Context 用量報告 | `context-report` |
| Session 回顧 / retro | `retro` |
| 多 Agent 協作 team | `agent-team` |
| Blog 文章分析 / Anthropic 新文 diff | `blog-analyzer` |
| 開新 prime session | `prime` |

## 歧義消解

兩個技能都可能匹配時：

1. **最具體優先**：`frontend-design` 比 `think` 更具體（僅限 UI）；`debug` 比 `hunt` 更具體（有 repro steps）。
2. **Commit 前 vs 架構 review**：staged changes 送 `deep-review`；完整 diff/PR 審查送 `check`。
3. **配置異常 vs 程式碼錯誤**：Claude 本身不聽話 / hook 不觸發 → `health`；程式丟出 exception → `hunt` / `debug`。
4. **兜底**：兩個都模糊時讀兩個 SKILL.md 的 `description`，用排除法；還是模糊就問使用者。

## 常見串聯

- `think` 出方案 → 實作 → `deep-review` 把關
- `research` / `learn` 收集材料 → `writing` 去 AI 味
- `hunt` / `debug` 定位根因 → 修完 → `check` 確認無副作用
- `health` 發現配置問題 → 修完再跑一次 `health`
- `spec-interview` 釐清需求 → `think` 設計方案 → 實作 → `deep-review`
