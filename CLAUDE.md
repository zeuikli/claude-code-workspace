# CLAUDE.md

> 繁體中文優先 · English supported · Repo: <https://github.com/zeuikli/claude-code-workspace>

## 四層載入框架

```
🔴 Real-time  — session-init.sh hook + CLAUDE.md 本體
🟡 Auto       — 3 rules @-imported (core/subagent/context) ~1,700 tok
🟢 On-demand  — 16 skills + 6 rules：說觸發詞才載入
⚪ Skip       — docs/archive, reference docs：手動 Read 即可
```

> 💡 `/load-plan` 查看完整清單含 token 估算

---

## 核心原則

- **IMPORTANT**: 中文用台灣繁體，英文用英文。
- **IMPORTANT**: 研究 / 實作 / 測試**優先委派 Sub Agent**，主對話僅接收摘要。
- **IMPORTANT**: 採 **Advisor 模式** — Haiku/Sonnet 執行、Opus 僅在架構決策時諮詢。
- **IMPORTANT**: Context 達 70% 立即提醒開新對話；達 60% 時按需載入 `session-management.md`。
- **IMPORTANT**: 改動完成 → `git add → commit → push -u origin <branch>`（失敗重試 4 次）。
- **IMPORTANT**: 跨對話記憶由**官方 Auto Memory** 管理（`/memory`），不手動維護。
- **IMPORTANT**: 實作前先說出理解與假設，再開始寫程式。

## 常駐規則（🟡 自動載入，約 1,700 tok）

- @.claude/rules/core.md
- @.claude/rules/subagent-strategy.md
- @.claude/rules/context-management.md

## 按需載入（🟢 說觸發詞才載入）

> 詳細觸發詞與 token 估算：執行 `/load-plan`

### Workspace
| 觸發詞 | 載入 |
|---|---|
| `/load-plan`、skill 地圖 | `skills/load-plan` |
| 冷啟、接手 codebase | `skills/prime` |
| Session 回顧、`/compact` 前 | `skills/retro` |
| Context 效率報告 | `skills/context-report` |
| Context > 60%、`/compact` | `rules/session-management` |
| Context > 70%、token 優化 | `rules/token-efficiency` |
| Opus 4.7 調校、架構決策 | `rules/opus47-best-practices` |
| 撰寫提示 | `prompts.md` |

### 開發
| 觸發詞 | 載入 |
|---|---|
| 除錯、測試失敗 | `skills/debug` |
| 效能分析 | `skills/perf` |
| 大型重構前 | `skills/map` |
| 前端、UI | `skills/frontend-design` |
| Commit 前審查 | `skills/deep-review` |
| 功能規劃、需求訪談 | `skills/spec-interview` |
| 排程、webhook、routine | `rules/routines` |
| CLI 工具（ast-grep / yq） | `rules/cli-enhancers` |
| 新增 Skill / Agent / Tool | `skills/add-skill` |
| SessionStart hook 細節 | `rules/auto-sync` |

### 其他
| 觸發詞 | 載入 |
|---|---|
| 行銷策略、文案、SEO | `skills/marketing` + `skills/writing` |
| 市場調查、競品分析 | `skills/research` |
| Sprint、PM、多 Agent 平行 | `skills/pm` + `skills/agent-team` |

## 進階文件（⚪ Skip / 手動 Read）

- `docs/INDEX.md` — 文件總索引
- `docs/advisor-strategy.md` — Advisor 模式完整論述
- `.claude/REFERENCES.md` — 官方文件對照表
