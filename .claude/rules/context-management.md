---
description: Context Window 管理 + Compaction 指引（含 1M context GA 策略）
---

# Context Window 管理

- 當 context window 使用量接近 **70%** 時，**立即通知使用者**開設新對話接續作業。
- 跨對話記憶由**官方 Auto Memory** 自動管理（無需手動維護 Memory.md）。
  - Claude 自動在 `~/.claude/projects/<project>/memory/` 累積記憶
  - 使用 `/memory` 指令查看或編輯 Auto Memory 內容

## 1M Context GA 策略

> 來源：[1M context is now generally available](https://claude.com/blog/1m-context-ga)（2026-03-13）

- Opus 4.6 / Sonnet 4.6 的 1M context 已正式 GA，**不收長 context 額外費用**。
- Claude Code Max / Team / Enterprise 用戶：Opus 4.6 session 自動使用完整 1M context。
- **影響**：compaction 壓力大幅降低，不再需要激進清除對話歷史。
- 整個 codebase、數千頁文件、長跑 Agent 的完整工具呼叫紀錄都可直接放入 context。
- 雖然 compaction 壓力減少，**70% 提醒仍需維持**，避免主對話承擔不必要的大量原始內容（研究任務仍應委派 Sub Agent）。

## Compaction 指引

當對話被壓縮時，務必保留：
- 已修改的檔案完整清單
- 測試指令
- 未完成的 Todo
- 所有關鍵決策紀錄
