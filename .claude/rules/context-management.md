---
description: Context Window 管理 — Token 預算 / Compact 觸發 / Prompt Caching（常駐載入）
tier: auto
---

# Context Window 管理

## Prompt Caching 核心原則（Static First）

- CLAUDE.md 內容 = 最穩定快取前綴，永遠放最前，不動。
- **Mid-session 禁止**：① 切換模型 ② 增刪 tool ③ 修改 CLAUDE.md → 等 session 結束後執行。能力升級需求 → 經 sub-agent model override 或新 session，不切主對話模型。
- **NLAH 原則**：Right context > more context；context 放 HEAD（原始目標）或 TAIL（最新工具輸出），中間放動態狀態。

## 監控

- `/usage` 查 token / cost 即時用量。
- 使用量接近 **70%** 時**立即通知使用者**，建議 `/compact <hint>`（繼續手上任務）或 `/clear`（任務即將切換）。
- **Compact 觸發**（優先序：行為信號 > 數字閾值）：
  1. **行為信號**：模型出現「請提供更多上下文」「你想做什麼？」等迷失問句 → 立即 `/rewind` 或 `/compact`
  2. **數字閾值**：一般任務 **70%**；長 agentic **30–35%** 主動 compact

## Compact hint

`/compact 保留：任務目標、最近工具結果（含完整 file path 與 error string 原文，勿改寫）、安全紅線、慣例、語言偏好；捨棄：中間步驟詳情、已被取代的探索路徑`

- **Compact 後自檢**：① 任務目標仍在？② 安全紅線仍在？③ 最近工具結果未失真？任一失 → `/rewind`。

## Auto Memory（跨 session 記憶）

- 啟用 `autoMemoryEnabled: true`；Claude 自動累積於專案 memory 目錄。
- `/memory` 查看或編輯；`/clear` 與 `/compact` 不影響 Auto Memory。
- 跨 session / 架構決策 → 先讀 memory；勿依賴 compact 後記憶。

## Token Budget（軟性參考）

- per-task ~**4,000** / per-session ~**30,000** tokens——委派與迭代任務的參考預算，非硬牆；行為信號永遠優先於數字。明顯超支 → 浮現回報，不靜默續燒。

## Prompt Caching 架構規則

| 規則 | 說明 |
|------|------|
| **Static first, dynamic last** | system prompt（靜態）→ CLAUDE.md（半靜態）→ tools（固定）→ 對話（動態）。同一專案共享 CLAUDE.md cache |
| **工具列表不能 mid-session 改變** | tools 是 cached prefix 的一部分，session 中途增刪工具會讓整個對話 cache 失效 |
| **不能 mid-session 換模型** | caching 是 per-model，換模型 = 清空所有 cache（成本驟增）|
| **`defer_loading: true`** | 工具以輕量 stub 存在，模型透過 `ToolSearch` 動態取得，保持 cached prefix 穩定 |
