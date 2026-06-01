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

> 1M context 已 GA 不額外收費；compaction 壓力低。

> **Context rot 閾值**（Thariq @trq212, 2026-04-16 驗證）：約 **300–400k tokens** 開始影響輸出品質，高度依賴任務類型，非硬性規則。70% 提醒仍是操作基準。

> **進階 compact / rewind 策略**：按需載入 `.claude/rules/session-management.md`。

## Prompt Caching 架構規則（Thariq @trq212, 2026-02-19 驗證）

> 「你根本上必須以 prompt caching 優先來設計 agent，幾乎每個功能都會碰到它」

| 規則 | 說明 |
|------|------|
| **Static first, dynamic last** | system prompt（靜態）→ CLAUDE.md（半靜態）→ tools（固定）→ 對話（動態）。所有用戶共享 system prompt cache；同一專案共享 CLAUDE.md cache |
| **工具列表不能 mid-session 改變** | tools 是 cached prefix 的一部分，session 中途新增 / 移除工具會讓整個對話 cache 失效 |
| **不能 mid-session 換模型** | caching 是 per-model，換模型 = 清空所有 cache（成本驟增）|
| **`defer_loading: true`** | 解法：工具以輕量 stub 存在（不展開 schema），模型透過 `ToolSearch` 動態取得需要的工具。讓 cached prefix 保持穩定 |
| **Mid-conversation system messages（Opus 4.8 新增）** | 4.8 允許在 user turn 後插入 `role:"system"` 更新指令，**保留前段 prompt cache hit**、降低 agentic loop 成本（無需 beta header）。長 session 中途追加指令不必重建整段歷史。⚠️ 仍不可 mid-session 改工具列表或換模型。來源：[mid-conversation system messages](https://platform.claude.com/docs/en/build-with-claude/mid-conversation-system-messages) |

> **Opus 4.8 prompt cache 門檻**：最低可 cache prompt 長度降至 **1,024 token**（低於 4.7），原本太短無法 cache 的 prompt 現在也能建立 cache entry。來源：[whats-new-claude-4-8](https://platform.claude.com/docs/en/about-claude/models/whats-new-claude-4-8)
