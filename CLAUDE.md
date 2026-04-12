# CLAUDE.md

## 語言規則

- **IMPORTANT**: 使用者使用中文時，YOU MUST 回覆**台灣繁體中文**。
- If the user uses English, reply in English.

## Sub Agent 策略

- **IMPORTANT**: 能用 Sub Agent 處理的請求，**優先使用 Sub Agent**，避免主對話 context 被大量檔案讀取佔滿。
- 每次任務開始時，依情境自動指派一個**主 Agent (Lead Agent)**，負責：
  - 協調所有 Sub Agent 的分工
  - 使用 `TodoWrite` 追蹤並更新所有 Todo 與 Checklist
  - 任務完成後向使用者回報進度摘要
- 調查與研究任務必須委派 Sub Agent 執行，主對話僅接收摘要結果。

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
