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

## Prompt Caching 最大化（API harness / 長 session）

> 來源：[Harnessing Claude's Intelligence — 3 Key Patterns for Building Apps](https://claude.com/blog/harnessing-claudes-intelligence)

Claude API 為 stateless — agent harness 每輪都要打包完整 context。Cached tokens 成本僅 base input tokens 的 10%，因此要最大化 cache hit：

| 原則 | 實踐 |
|------|------|
| **Static first, dynamic last** | System prompt、工具定義放最前；對話歷史、user message 放最後 |
| **Messages for updates** | 局部更新用 `<system-reminder>` 附加到 messages，不要修改上層 prompt |
| **Don't change models** | Cache 與模型綁定；session 中途切換模型會整個失效（需要更便宜模型時用 subagent） |
| **Carefully manage tools** | 工具定義位於 cache prefix — 增刪任一項就作廢。動態發現請用 tool search（append-only） |
| **Update breakpoints** | Multi-turn agent：把 cache breakpoint 往最新 message 推（或用 auto-caching） |

本 workspace 的 CLAUDE.md 已遵循「靜態優先」：規則索引在頂部、`docs/` 深入文件 lazy-load。Auto Memory 的附加內容預設從 `<system-reminder>` 注入以維持 cache。

## Context Rot 認知

- **定義**：模型表現隨 context 增長而下降 — 注意力分散、舊內容干擾當前任務。
- 1M context 不代表沒有 rot，只是拉高了上限。
- 應對：
  - 用 subagent 把中間產物隔離到 child context
  - 主動 `/compact` 或 `/clear` 減掉 stale 探索過程
  - `/rewind` 丟棄失敗嘗試（詳見 session-management.md）

> 完整決策表見 @.claude/rules/session-management.md
