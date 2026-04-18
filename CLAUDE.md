# CLAUDE.md

> **繁體中文優先 · English supported** · Repo: <https://github.com/zeuikli/claude-code-workspace>
>
> 依使用者語言自動切換回覆語系。Replies match the user's language automatically.

## 四層載入框架 | 4-Tier Load Framework

```
🔴 真實載入  Real-time   — session-init.sh hook + CLAUDE.md 本體
🟡 自動載入  Auto        — 3 rules @-imported (core / subagent / context) ~1,700 tok
🟢 按需載入  On-demand   — 16 skills + 6 rules：說觸發詞才載入
⚪ 不必載入  Skip        — docs/archive / reference docs：手動 Read 即可
```

> 💡 執行 `/load-plan` 查看完整清單含 token 估算

---

## 核心原則 | Core Principles

- **IMPORTANT**: 中文用台灣繁體，英文用英文。/ Reply in Traditional Chinese for Chinese, English for English.
- **IMPORTANT**: 研究 / 實作 / 測試**優先委派 Sub Agent**，主對話僅接收摘要。
- **IMPORTANT**: 採 **Advisor 模式** — Haiku/Sonnet 執行、Opus 僅在架構決策時諮詢。
- **IMPORTANT**: Context 達 70% 立即提醒開新對話；達 60% 時**按需載入** `session-management.md`。
- **IMPORTANT**: 改動完成 → `git add → commit → push -u origin <branch>`（失敗重試 4 次）。
- **IMPORTANT**: 跨對話記憶由**官方 Auto Memory** 管理（`/memory`），不手動維護。
- **IMPORTANT**: 實作前先說出理解與假設，再開始寫程式。

## 常駐規則（🟡 自動載入，約 1,700 tok）

- @.claude/rules/core.md — 語言 / Git / 品質三合一 / Language, Git, Quality
- @.claude/rules/subagent-strategy.md — Advisor 模式 + Sub Agent 委派
- @.claude/rules/context-management.md — Context 監控 / Context monitoring

## 按需載入 | On-demand（🟢 說觸發詞即載入，不說不佔 context）

> 💡 `/load-plan` 隨時顯示完整清單與觸發詞 · `/load-plan` shows the full list with token costs

### 🔧 Workspace 管理 | Workspace
| 觸發條件 · Trigger | 載入 · Loads |
|---|---|
| 查看載入計畫、可用 skill 地圖 | `/load-plan` skill |
| 新 session 冷啟、接手陌生 codebase · Cold-start | `.claude/skills/prime/SKILL.md` |
| Session 回顧 / `/compact` 前記錄決策 | `.claude/skills/retro/SKILL.md` |
| 模型效率 / 成本分析 | `.claude/skills/context-report/SKILL.md` |
| Context > 60% · `/compact` / `/rewind` | `.claude/rules/session-management.md` |
| Context > 70% · token 優化 | `.claude/rules/token-efficiency.md` |
| Opus 4.7 調校 / 架構決策 | `.claude/rules/opus47-best-practices.md` |
| 撰寫提示 · Prompt engineering | `prompts.md` |

### 🖥 程式開發 | Development
| 觸發條件 · Trigger | 載入 · Loads |
|---|---|
| 除錯、測試失敗、生產 error · Bug/test failure | `.claude/skills/debug/SKILL.md` |
| 效能分析 · Performance analysis | `.claude/skills/perf/SKILL.md` |
| 大型重構前 · Pre-refactor codebase map | `.claude/skills/map/SKILL.md` |
| 前端開發、UI 設計 · Frontend/UI | `.claude/skills/frontend-design/SKILL.md` |
| Commit 前審查 · Pre-commit review | `.claude/skills/deep-review/SKILL.md` |
| 排程、webhook、routine 設定 | `.claude/rules/routines.md` |
| CLI 工具（ast-grep / yq / delta）| `.claude/rules/cli-enhancers.md` |
| 新增 Skill / Agent / Tool | `.claude/skills/add-skill/SKILL.md` |
| SessionStart hook 細節 | `.claude/rules/auto-sync.md` |

### 📣 行銷 / 文案 | Marketing & Writing
| 觸發條件 · Trigger | 載入 · Loads |
|---|---|
| 行銷策略、GTM、A/B 測試 · Campaigns, GTM | `.claude/skills/marketing/SKILL.md` |
| 文案、SEO、Email、Landing Page | `.claude/skills/writing/SKILL.md` |
| 進階提示模板 · Advanced prompt templates | `docs/prompts-advanced.md` |

### 🔍 研究 / 分析 | Research & Analysis
| 觸發條件 · Trigger | 載入 · Loads |
|---|---|
| 市場調查、競品、文獻 · Market/competitive research | `.claude/skills/research/SKILL.md` |
| Claude Code best practice 審計 | `.claude/skills/research-best-practices/SKILL.md` |

### 📋 專案管理 | Project Management
| 觸發條件 · Trigger | 載入 · Loads |
|---|---|
| Sprint、排程、狀態報告 · Sprint planning | `.claude/skills/pm/SKILL.md` |
| 多 Agent 平行執行 · Multi-agent parallel | `.claude/skills/agent-team/SKILL.md` |

## 進階文件（⚪ 不必載入 · Skip / Reference only）

- `docs/INDEX.md` — 文件總索引 / Full doc index
- `docs/advisor-strategy.md` — Advisor 模式完整論述
- `docs/prompt-caching-verification.md` — 驗證 cache hit 的方法
- `docs/timeout-guide.md` — Timeout 指南
- `.claude/REFERENCES.md` — 官方文件對照表
