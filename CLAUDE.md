# CLAUDE.md

> Claude Code 個人工作區指令檔（Opus 4.7 + Sonnet 4.6 優化版）
> Repo: <https://github.com/zeuikli/claude-code-workspace>

## 核心原則（Opus 4.7 最佳實踐）

- **IMPORTANT**: 中文對話用**台灣繁體中文**，英文對話用英文。
- **IMPORTANT**: 採 **Advisor 模式** — Sonnet 4.6 / Haiku 4.5 執行主迴圈、Opus 4.7 退居幕後擔任顧問，僅在架構決策時諮詢。
- **IMPORTANT**: 把 Claude 當資深工程師委派，**第一輪就給完整規格**（意圖、限制、驗收條件、檔案路徑），避免多輪補充指令耗 token 且稀釋 Opus 4.7 的推理效能。
- **IMPORTANT**: Opus 4.7 預設 `xhigh` effort（`high` 與 `max` 之間），採**自適應思考**（無固定 thinking budget）；需要更快回覆時明確說「優先快速回答」，需要更深推理時說「這題比想像中難，請仔細逐步思考」。
- **IMPORTANT**: Opus 4.7 預設**較少主動 spawn subagent 與呼叫工具**；需要平行委派或積極搜尋時，**要在 prompt 中明確指示**（例：「請同時開多個 subagent 處理 A/B/C」）。
- **IMPORTANT**: 能用 Sub Agent 處理的研究/實作/測試任務**優先委派**，主對話只接收摘要，避免 context rot。
- **IMPORTANT**: Context 接近 **70%** 時提醒開新 session；長 session 中優先用 `/rewind`（esc esc）而非「那個沒用，試 X」去修正錯誤方向。
- **IMPORTANT**: 改動完成後 `git add → commit → push -u origin <branch>`（失敗重試 4 次：2s/4s/8s/16s）。
- **IMPORTANT**: 跨對話記憶由 **官方 Auto Memory** 自動管理（`/memory`），無需手動維護。

## 規則索引（按需載入）

完整規則拆分於 `.claude/rules/`，需要時再 Read：

- @.claude/rules/language.md — 語言回覆規則
- @.claude/rules/opus47-best-practices.md — **Opus 4.7 調校指南（effort、thinking、subagent 行為）**
- @.claude/rules/subagent-strategy.md — Sub Agent 委派與 Advisor 模式（含 Opus 4.7 顯式委派規則）
- @.claude/rules/session-management.md — **Session / context / 1M 視窗 / rewind 決策表**
- @.claude/rules/context-management.md — Context 監控與 compaction（含 1M context 策略）
- @.claude/rules/git-workflow.md — Git 自動化流程
- @.claude/rules/quality.md — 測試與驗證（含 xhigh 努力級別與自適應思考指引）
- @.claude/rules/routines.md — **Claude Code Routines（排程/API/webhook 自動化）**

## 進階文件（lazy-load，**不主動載入**）

需要時再讀取：

- `docs/INDEX.md` — 進階文件總索引
- `docs/advisor-strategy.md` — Advisor 模式完整論述（含 Opus 4.7 + `advisor_20260301` API）
- `docs/opus47-migration.md` — **Opus 4.6 → 4.7 遷移指引**
- `docs/multi-agent-coordination.md` — **5 種多 agent 協調模式決策表**（Generator-Verifier / Orchestrator-Subagent / Agent Teams / Message Bus / Shared State）
- `docs/timeout-guide.md` — Timeout 設定完整指南
- `.claude/REFERENCES.md` — **官方文件對照表（所有設計決策的 URL 來源）**

## 參考文件

- @prompts.md — 萬用 Prompt（含 Opus 4.7 首輪前置規格、xhigh 努力級別、Auto Mode 模式）
