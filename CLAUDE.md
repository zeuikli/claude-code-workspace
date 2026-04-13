# CLAUDE.md

## 語言規則

- **IMPORTANT**: 使用者使用中文時，YOU MUST 回覆**台灣繁體中文**。
- If the user uses English, reply in English.

## Sub Agent 策略與 Advisor 模式

- **IMPORTANT**: 能用 Sub Agent 處理的請求，**優先使用 Sub Agent**，避免主對話 context 被大量檔案讀取佔滿。
- 每次任務開始時，依情境自動指派一個**主 Agent (Lead Agent)**，負責：
  - 協調所有 Sub Agent 的分工
  - 使用 `TodoWrite` 追蹤並更新所有 Todo 與 Checklist
  - 任務完成後向使用者回報進度摘要
- 調查與研究任務必須委派 Sub Agent 執行，主對話僅接收摘要結果。

### Advisor 模式（顧問策略）

> 依據 [AgentOpt 論文](https://arxiv.org/html/2604.06296v1) 與 [Anthropic Advisor Strategy](https://claude.com/blog/the-advisor-strategy)

- **IMPORTANT**: 主迴圈由 **Haiku / Sonnet 擔任執行者**，**Opus 退居幕後當顧問**。
- 執行者負責：驅動任務、讀寫檔案、呼叫工具、逐步推進。
- 顧問負責：僅在關鍵時刻提供策略建議，不直接操作。
- **何時諮詢 Opus 顧問**：
  - 架構層級的設計決策或跨模組重構
  - 邊界案例判斷與不確定的技術選型
  - 複雜邏輯的程式碼審查與安全性審計
- **不需諮詢 Opus**：簡單搜尋、格式化、已知模式的重複性工作、執行測試與 lint。
- Sub Agent 模型分層：`Haiku`（搜尋 / 探索）→ `Sonnet`（實作 / 測試）→ `Opus`（架構 / 審查）。
- 詳細說明：@docs/advisor-strategy.md

### Sub Agent 委派規則

- **研究型任務**（>10 檔案）：使用 `researcher` 或 `architecture-explorer`（Haiku）
- **平行獨立工作**（3+ 子任務）：同時啟動多個 Sub Agent
- **程式碼實作**：使用 `implementer`（Sonnet）
- **測試撰寫**：使用 `test-writer`（Sonnet）
- **安全審查**：使用 `security-reviewer`（Sonnet），非必要不調用 Opus
- **架構決策**：僅此情境使用 `reviewer`（Opus）
- **Commit 前驗證**：使用 `/deep-review` Skill 執行三維度平行審查
- **前端開發**：自動載入 `frontend-design` Skill 避免 AI slop

## Context Window 管理

- 當 context window 使用量接近 **70%** 時，**立即通知使用者**開設新對話接續作業。
- 在通知前，自動建立或更新 `Memory.md`，記錄：
  - 目前的工作進度與未完成項目
  - 已修改的檔案清單
  - 關鍵決策與技術選型
  - 下一步待辦事項
- **Compaction 指引**: 當對話被壓縮時，務必保留：已修改的檔案完整清單、測試指令、未完成的 Todo、以及所有關鍵決策紀錄。

## Git 工作流程

- **IMPORTANT**: 每次改動完成後，YOU MUST 執行以下步驟：
  1. `git add` 相關檔案（避免 `git add -A`，防止加入敏感檔案）
  2. `git commit` 並撰寫清晰的 commit message
  3. `git push -u origin <branch-name>`（失敗時重試最多 4 次，間隔 2s/4s/8s/16s）
  4. Merge 到 `main` branch 並推送到 GitHub
- 根據改動內容，**按需更新**：
  - `README.md` — 專案說明、安裝步驟、使用方式
  - `CHANGELOG.md` — 版本變更紀錄（格式：日期 + 變更摘要）

## 驗證與品質

- 每次程式碼變更後，優先執行相關測試或 lint 驗證。
- 若專案有測試套件，優先跑單一相關測試而非全部測試（提升效能）。
- UI 變更時，嘗試截圖比對或啟動 dev server 驗證。

## 自動化同步機制

- **SessionStart Hook**: 每次 session 啟動時自動拉取最新的 CLAUDE.md 與 Memory.md（本機 git pull / 雲端 git clone）。
- **PreToolUse Hook**: 讀取 Memory.md 前自動從 GitHub 拉取最新版本，確保跨 session 記憶一致。
- **PostToolUse Hook**: 偵測 Memory.md 被寫入後，自動 commit 並推送回 GitHub。
- **IMPORTANT**: Memory.md 的 git 操作（add / commit / push）由 Hook 自動處理，**不需要手動執行**。
- **跨專案共用**: 其他專案只需在 `.claude/settings.json` 加入相同的 SessionStart Hook，即可自動載入此 workspace 的設定。

## 參考文件

- 專案總覽：@README.md
- 對話記憶：@Memory.md
- 變更紀錄：@CHANGELOG.md
- 萬用 Prompt：@prompts.md
- Advisor 模式：@docs/advisor-strategy.md
