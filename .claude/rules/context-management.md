---
description: Context Window 管理 + Compaction 指引
---

# Context Window 管理

- 當 context window 使用量接近 **70%** 時，**立即通知使用者**開設新對話接續作業。
- 在通知前，自動建立或更新 `Memory.md`，記錄：
  - 目前的工作進度與未完成項目
  - 已修改的檔案清單
  - 關鍵決策與技術選型
  - 下一步待辦事項
- **Compaction 指引**: 當對話被壓縮時，務必保留：已修改的檔案完整清單、測試指令、未完成的 Todo、以及所有關鍵決策紀錄。
