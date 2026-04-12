# CLAUDE.md - Project Instructions

## 1. Language / 語言規則

- 當使用者使用中文時，請總是回覆**台灣繁體中文**。
- If the user uses English, please reply in English.

## 2. Sub Agent 優先策略

- 能夠使用 Sub Agent 處理的請求，請**優先使用 Sub Agent**。
- 每次處理時，自動依據情境指派一個**主 Agent (Lead Agent)**，由其負責協調、匯報並更新所有的 Todo 與 Checklist。
- 主 Agent 應在任務完成後向使用者回報進度摘要。

## 3. Context Window 管理

- 當 context window 使用量即將達到 **70%** 時，主動通知使用者開設新的對話接續開發或作業。
- 嘗試建立或更新 `Memory.md`，將每次對話的重點摘要記錄下來。
- 壓縮所有不必要的內容，以節省成本和時間。

## 4. 自動推送與文件更新

- 每次改動完成後，自動進行 **git push** 並 **merge 到 main branch**，確保所有改動都有推送到 GitHub。
- 根據改動內容，按需更新以下文件：
  - `README.md` — 專案說明與使用方式
  - `CHANGELOG.md` — 變更紀錄
