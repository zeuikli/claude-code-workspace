---
description: Context Window 監控 + 1M context GA + Prompt Caching（進階 session 管理見 session-management.md）
---

# Context Window 管理

## 監控

- `/usage` 查看本 session 的 token/cost 即時用量。
- 使用量接近 **70%** 時**立即通知使用者**，建議：
  - `/compact <hint>`（低成本、繼續手上任務）
  - `/clear`（任務即將切換）
  - 開新 terminal session（並行工作流）

## Auto Memory（跨 session 記憶）

- `.claude/settings.json` 設 `"autoMemoryEnabled": true`
- Claude 自動累積於 `~/.claude/projects/<project>/memory/`
- `/memory` 查看或編輯；`/clear` 與 `/compact` 不影響 Auto Memory

## 1M Context GA

> 來源：[1M context is now generally available](https://claude.com/blog/1m-context-ga)（2026-03-13）
> 📦 離線歸檔：[`archive/articles/1m-context-ga.md`](https://github.com/zeuikli/claude-code-workspace/blob/blog-archive/archive/articles/1m-context-ga.md)

- Opus 4.6 / Sonnet 4.6 的 1M context 已 GA，**不收長 context 額外費用**。
- Claude Code Max/Team/Enterprise：Opus session 自動使用完整 1M。
- **影響**：compaction 壓力大幅降低；整個 codebase、長跑 Agent 紀錄可直接放入 context。

## Prompt Caching 最大化

> 來源：[Harnessing Claude's Intelligence](https://claude.com/blog/harnessing-claudes-intelligence)
> 📦 離線歸檔：[`archive/articles/harnessing-claudes-intelligence.md`](https://github.com/zeuikli/claude-code-workspace/blob/blog-archive/archive/articles/harnessing-claudes-intelligence.md)

Claude API stateless — 每輪打包完整 context。Cached tokens 僅 base input 10% 成本：

| 原則 | 實踐 |
|------|------|
| **Static first, dynamic last** | System prompt / 工具定義最前；user message 最後 |
| **Messages for updates** | 局部更新用 `<system-reminder>` 附加，不改上層 prompt |
| **Don't change models** | Cache 與模型綁定；中途切換會整個失效（用 subagent 取代） |
| **Manage tools carefully** | 工具定義在 cache prefix — 增刪即作廢；動態發現用 tool search（append-only） |
| **Update breakpoints** | Multi-turn：把 breakpoint 往最新 message 推 |

本 workspace：規則索引在 CLAUDE.md 頂部、`docs/` 深入文件 lazy-load、Auto Memory 從 `<system-reminder>` 注入以維持 cache。驗證方法見 `docs/prompt-caching-verification.md`。

> **進階 compaction / rewind / context rot 應對、主動 compact 策略**：按需載入 `.claude/rules/session-management.md`。
