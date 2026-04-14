---
description: Context Window 管理 + Compaction 指引
---

# Context Window 管理

- 當 context window 使用量接近 **70%** 時，**立即通知使用者**開設新對話接續作業。
- 跨對話記憶由**官方 Auto Memory** 自動管理（無需手動維護 Memory.md）。
  - Claude 自動在 `~/.claude/projects/<project>/memory/` 累積記憶
  - 使用 `/memory` 指令查看或編輯 Auto Memory 內容
- **Compaction 指引**: 當對話被壓縮時，務必保留：已修改的檔案完整清單、測試指令、未完成的 Todo、以及所有關鍵決策紀錄。
