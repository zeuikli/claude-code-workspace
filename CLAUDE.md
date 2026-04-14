# CLAUDE.md

> Claude Code 個人工作區指令檔
> Repo: <https://github.com/zeuikli/claude-code-workspace>

## 核心原則

- **IMPORTANT**: 中文對話用**台灣繁體中文**，英文對話用英文。
- **IMPORTANT**: 能用 Sub Agent 處理的請求**優先委派 Sub Agent**，主對話僅接收摘要。
- **IMPORTANT**: 採 Advisor 模式 — Haiku/Sonnet 執行、Opus 顧問（僅關鍵架構決策時諮詢）。
- **IMPORTANT**: Context 接近 70% 時更新 `Memory.md` 並提醒使用者開新對話。
- **IMPORTANT**: 改動完成後 `git add → commit → push -u origin <branch>`（失敗重試 4 次）。

## 規則索引（按需載入）

完整規則拆分於 `.claude/rules/`，需要時再 Read：

- @.claude/rules/language.md — 語言回覆規則
- @.claude/rules/subagent-strategy.md — Sub Agent 委派與 Advisor 模式
- @.claude/rules/context-management.md — Context 與 compaction 管理
- @.claude/rules/git-workflow.md — Git 自動化流程
- @.claude/rules/quality.md — 測試與驗證
- @.claude/rules/auto-sync.md — Hook 自動化機制

## 進階文件（lazy-load，**不主動載入**）

需要時再讀取：

- `docs/INDEX.md` — 進階文件總索引
- `docs/advisor-strategy.md` — Advisor 模式完整論述
- `docs/blog-analysis-report.md` — 22 篇 Anthropic Blog 洞察
- `docs/workspace-performance-report.md` — 效能基準與優化紀錄

## 參考文件

- @README.md — 專案總覽
- @Memory.md — 跨對話記憶
- @CHANGELOG.md — 變更紀錄
- @prompts.md — 萬用 Prompt
