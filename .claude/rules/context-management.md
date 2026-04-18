---
description: Context Window 監控 + 1M context GA + Prompt Caching（進階 session 管理見 session-management.md）
tier: auto
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

> 1M context 已 GA 不額外收費；compaction 壓力低。Cache 最佳化：保持 system prompt 靜態、model 不在 session 中途切換。詳見 `docs/prompt-caching-verification.md`。

> **進階 compact / rewind 策略**：按需載入 `.claude/rules/session-management.md`。
