# CLAUDE.md

> Claude Code 個人工作區指令檔
> Repo: <https://github.com/zeuikli/claude-code-workspace>

## 核心原則

- **IMPORTANT**: 中文對話用**台灣繁體中文**，英文對話用英文。
- **IMPORTANT**: 能用 Sub Agent 處理的請求**優先委派 Sub Agent**，主對話僅接收摘要。
- **IMPORTANT**: 採 Advisor 模式 — Haiku/Sonnet 執行、**Opus 4.7** 顧問（僅關鍵架構決策時諮詢）。
- **IMPORTANT**: Opus 4.7 預設 `xhigh` 努力級別；**平行展開 Sub Agent 時必須顯式說明**（4.7 預設委派較保守）。
- **IMPORTANT**: 對 Opus 4.7 下任務：**第一輪就給完整規格**（意圖 + 限制 + 驗收標準 + 相關檔案路徑），減少來回次數。
- **IMPORTANT**: Context 接近 70% 時提醒使用者開新對話（1M context GA，主對話負擔仍需注意）。
- **IMPORTANT**: 改動完成後 `git add → commit → push -u origin <branch>`（失敗重試 4 次）。
- **IMPORTANT**: 跨對話記憶由 **官方 Auto Memory** 自動管理（`/memory` 指令），無需手動維護。

## 規則索引（按需載入）

完整規則拆分於 `.claude/rules/`，需要時再 Read：

- @.claude/rules/language.md — 語言回覆規則
- @.claude/rules/subagent-strategy.md — Sub Agent 委派與 Advisor 模式（含 Opus 4.7 顯式委派規則）
- @.claude/rules/context-management.md — Context 與 compaction 管理（含 1M context 策略）
- @.claude/rules/git-workflow.md — Git 自動化流程
- @.claude/rules/quality.md — 測試與驗證（含 xhigh 努力級別與自適應思考指引）

## 進階文件（lazy-load，**不主動載入**）

需要時再讀取：

- `docs/INDEX.md` — 進階文件總索引
- `docs/advisor-strategy.md` — Advisor 模式完整論述（含 Opus 4.7 + `advisor_20260301` API）
- `docs/timeout-guide.md` — Timeout 設定完整指南
- `.claude/REFERENCES.md` — **官方文件對照表（所有設計決策的 URL 來源）**

## 參考文件

- @prompts.md — 萬用 Prompt（含 Opus 4.7 首輪前置規格、xhigh 努力級別、Auto Mode 模式）
