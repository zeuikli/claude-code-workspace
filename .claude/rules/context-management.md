---
description: Context Window 監控 + Compaction 指引（含 1M context GA 策略，與 session-management.md 互補）
---

# Context Window 管理

## 監控

- Claude Code 內建 `/usage` 指令 — 查看本 session 的 token/cost 即時用量。
- 使用量接近 **70%** 時，**立即通知使用者**，建議以下選項之一：
  - `/compact <hint>`（低成本、繼續手上任務）
  - `/clear`（任務即將切換、想精確控制 carry-over）
  - 開新 terminal session（不同工作流並行）

## Auto Memory（跨 session 記憶）

- 啟用於 `.claude/settings.json`：`"autoMemoryEnabled": true`
- Claude 自動在 `~/.claude/projects/<project>/memory/` 累積跨 session 知識。
- 使用 `/memory` 指令查看或編輯 Auto Memory 內容。
- `/clear` 與 `/compact` 不影響 Auto Memory。

## 1M Context GA 策略

> 來源：[1M context is now generally available](https://claude.com/blog/1m-context-ga)（2026-03-13）

- Opus 4.6 / Sonnet 4.6 的 1M context 已正式 GA，**不收長 context 額外費用**。
- Claude Code Max / Team / Enterprise 用戶：Opus 4.6 session 自動使用完整 1M context。
- **影響**：compaction 壓力大幅降低，不再需要激進清除對話歷史。
- 整個 codebase、數千頁文件、長跑 Agent 的完整工具呼叫紀錄都可直接放入 context。
- 雖然 compaction 壓力減少，**70% 提醒仍需維持**，避免主對話承擔不必要的大量原始內容。

## Compaction 指引

當對話被壓縮（`/compact` 或 autocompact）時，務必保留：

- 已修改的檔案完整清單（含絕對路徑）
- 測試指令與執行結果
- 未完成的 Todo（`TodoWrite` 狀態）
- 所有關鍵決策紀錄（為何選 A 不選 B）

### 主動 compact 優於 autocompact

- autocompact 在 context rot 最嚴重時觸發 → 模型此時判斷最弱 → 摘要品質差。
- 1M context 給你更多時間**主動** `/compact`，並附上**下一步描述**當 hint：
  > `/compact focus on the auth refactor, drop the test debugging. Next step: add rate limiting.`

## Context Rot 認知

- **定義**：模型表現隨 context 增長而下降 — 注意力分散、舊內容干擾當前任務。
- 1M context 不代表沒有 rot，只是拉高了上限。
- 應對：
  - 用 subagent 把中間產物隔離到 child context
  - 主動 `/compact` 或 `/clear` 減掉 stale 探索過程
  - `/rewind` 丟棄失敗嘗試（詳見 session-management.md）

> 完整決策表見 @.claude/rules/session-management.md
