# CLAUDE.md

> Claude Code 個人工作區指令檔 · Repo: <https://github.com/zeuikli/claude-code-workspace>

## 核心原則（常駐）

- **IMPORTANT**: 中文用台灣繁體，英文用英文。
- **IMPORTANT**: 研究 / 實作 / 測試**優先委派 Sub Agent**，主對話僅接收摘要。
- **IMPORTANT**: 採 **Advisor 模式** — Haiku/Sonnet 執行、Opus 僅在架構決策時諮詢。
- **IMPORTANT**: Context 達 70% 立即提醒開新對話；達 60% 時**按需載入** `session-management.md`（見下表）。
- **IMPORTANT**: 改動完成 → `git add → commit → push -u origin <branch>`（失敗重試 4 次）。
- **IMPORTANT**: 跨對話記憶由**官方 Auto Memory** 管理（`/memory`），不手動維護。
## 常駐規則（@ 自動載入，約 3.5 KB）

- @.claude/rules/core.md — 語言 / Git / 品質三合一
- @.claude/rules/subagent-strategy.md — Advisor 模式 + Sub Agent 委派（含 Opus 4.7 顯式規則）
- @.claude/rules/context-management.md — Context 監控（含 1M 視窗策略）

## 按需載入（lazy-load · 說出觸發詞即載入 · 不說不佔 context）

> 💡 `/load-plan` 隨時顯示完整可用清單與觸發詞

### 🔧 Workspace 管理
| 觸發條件 | 載入 |
|---|---|
| 查看 workspace 載入計畫、可用 skill 地圖 | `.claude/skills/load-plan/SKILL.md` |
| 新 session 冷啟、接手陌生 codebase | `.claude/skills/prime/SKILL.md` |
| Session 結束回顧 / `/compact` 前記錄決策 | `.claude/skills/retro/SKILL.md` |
| 評估 session 模型效率 / 成本分析 | `.claude/skills/context-report/SKILL.md` |
| Context > 60%、執行 `/compact` / `/rewind` | `.claude/rules/session-management.md` |
| Context > 70% 或需優化 token 用量 | `.claude/rules/token-efficiency.md` |
| Opus 4.7 調校 / 深度架構決策 | `.claude/rules/opus47-best-practices.md` |
| 撰寫提示、啟動新 session | `prompts.md` |

### 🖥 程式開發
| 觸發條件 | 載入 |
|---|---|
| 除錯、測試失敗、生產 error 調查 | `.claude/skills/debug/SKILL.md` |
| 應用程式效能分析與最佳化 | `.claude/skills/perf/SKILL.md` |
| 大型重構前產出 codebase 符號地圖 | `.claude/skills/map/SKILL.md` |
| 前端開發、UI 設計 | `.claude/skills/frontend-design/SKILL.md` |
| Commit 前深度審查 | `.claude/skills/deep-review/SKILL.md` |
| 設定排程、webhook、長跑 routine | `.claude/rules/routines.md` |
| 高效 CLI 工具（ast-grep / yq / delta 等） | `.claude/rules/cli-enhancers.md` |
| 新增 Skill / Agent / Tool 前設計參考 | `docs/tool-design-principles.md` |
| 建立新 Skill（格式驗證與命名規則） | `.claude/skills/add-skill/SKILL.md` |
| 自動同步 / SessionStart hook 細節 | `.claude/rules/auto-sync.md` |

### 📣 行銷 / 文案
| 觸發條件 | 載入 |
|---|---|
| 行銷策略、GTM、活動規劃、A/B 測試 | `.claude/skills/marketing/SKILL.md` |
| 文案撰寫、SEO、Email 行銷、Landing Page | `.claude/skills/writing/SKILL.md` |
| 進階提示模板 | `docs/prompts-advanced.md` |

### 🔍 研究 / 分析
| 觸發條件 | 載入 |
|---|---|
| 市場調查、競品分析、文獻整理 | `.claude/skills/research/SKILL.md` |
| Claude Code best practice 季度審計 | `.claude/skills/research-best-practices/SKILL.md` |

### 📋 專案管理
| 觸發條件 | 載入 |
|---|---|
| Sprint 規劃、排程、優先排序、狀態報告 | `.claude/skills/pm/SKILL.md` |
| 大型任務多 Agent 平行執行 | `.claude/skills/agent-team/SKILL.md` |

## 進階文件（按需 Read）

- `docs/INDEX.md` — 文件總索引
- `docs/advisor-strategy.md` — Advisor 模式完整論述
- `docs/prompt-caching-verification.md` — 驗證 cache hit 的方法
- `docs/timeout-guide.md` — Timeout 指南
- `.claude/REFERENCES.md` — 官方文件對照表（所有設計決策的 URL 來源）
