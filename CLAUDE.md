# CLAUDE.md

> Claude Code 個人工作區指令檔 · Repo: <https://github.com/zeuikli/claude-code-workspace>

## 核心原則（常駐）

- **IMPORTANT**: 中文用台灣繁體，英文用英文。
- **IMPORTANT**: 研究 / 實作 / 測試**優先委派 Sub Agent**，主對話僅接收摘要。
- **IMPORTANT**: 採 **Advisor 模式** — Haiku/Sonnet 執行、Opus 僅在架構決策時諮詢。
- **IMPORTANT**: Context 達 70% 立即提醒開新對話；達 60% 時**按需載入** `session-management.md`（見下表）。
- **IMPORTANT**: 改動完成 → `git add → commit → push -u origin <branch>`（失敗重試 4 次）。
- **IMPORTANT**: 跨對話記憶由**官方 Auto Memory** 管理（`/memory`），不手動維護。
- Commit 前必跑 `/deep-review`；前端變更自動套用 `frontend-design` skill。

## 常駐規則（@ 自動載入，約 3.5 KB）

- @.claude/rules/core.md — 語言 / Git / 品質三合一
- @.claude/rules/subagent-strategy.md — Advisor 模式 + Sub Agent 委派（含 Opus 4.7 顯式規則）
- @.claude/rules/context-management.md — Context 監控（含 1M 視窗策略）

## 按需載入規則（lazy-load，**不要預先 Read**）

| 觸發條件 | 載入檔 |
|---|---|
| 做 Opus 4.7 調校 / 深度架構決策 | `.claude/rules/opus47-best-practices.md` |
| Context > 60%、執行 `/compact` / `/rewind` | `.claude/rules/session-management.md` |
| 設定排程、webhook、長跑 routine | `.claude/rules/routines.md` |
| 撰寫提示、啟動新 session | `prompts.md`（核心 3 條） |
| 進階提示模板 | `docs/prompts-advanced.md` |
| 自動同步 / SessionStart hook 細節 | `.claude/rules/auto-sync.md` |

## 進階文件（按需 Read）

- `docs/INDEX.md` — 文件總索引
- `docs/advisor-strategy.md` — Advisor 模式完整論述
- `docs/prompt-caching-verification.md` — 驗證 cache hit 的方法
- `docs/timeout-guide.md` — Timeout 指南
- `.claude/REFERENCES.md` — 官方文件對照表（所有設計決策的 URL 來源）
