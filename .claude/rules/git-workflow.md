---
description: Git 工作流程 — commit / push / merge 自動化
---

# Git 工作流程

- **IMPORTANT**: 每次改動完成後，YOU MUST 執行以下步驟：
  1. `git add` 相關檔案（避免 `git add -A`，防止加入敏感檔案）
  2. `git commit` 並撰寫清晰的 commit message
  3. `git push -u origin <branch-name>`（失敗時重試最多 4 次，間隔 2s/4s/8s/16s）
  4. Merge 到 `main` branch 並推送到 GitHub
- 根據改動內容，**按需更新**：
  - `README.md` — 專案說明、安裝步驟、使用方式
  - `CHANGELOG.md` — 版本變更紀錄（格式：日期 + 變更摘要）
