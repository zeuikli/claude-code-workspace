---
description: Opus 4.8 調校指南 — effort、自適應思考、subagent 行為、4.8 新功能
tier: ondemand
source: "Opus 4.8 官方文件（見文末參考網址）。前身 archive: archive/articles/best-practices-for-using-claude-opus-4-7-with-claude-code.md"
---

# Opus 4.8 最佳實踐

> 對齊官方 Opus 4.8（`claude-opus-4-8`，2026-05-28 發布，建構於 4.7）。
> 1M context 預設 · 128k max output · 僅支援 adaptive thinking · 不支援 temperature/top_p/top_k · knowledge cutoff 2026-01。
> 參考網址見文末。

## 1. Effort 等級（共 5 級，預設 `high`）

| Effort | 適用情境 | 備註 |
|--------|---------|------|
| `low` | 簡單任務、subagent、高量/延遲敏感 | 最省 token，官方點名適合 subagent |
| `medium` | 速度/成本/品質平衡的一般 agentic | 4.8 比 4.7 **允許略多思考** |
| `high`（**預設**） | 複雜推理、困難編碼、多數 agentic | 等同不設 effort；4.8 比 4.7 **略少思考** |
| `xhigh` | 編碼與長時 agentic 的**建議起點**、重度工具呼叫/搜尋 | 需**顯式設定**；4.8 比 4.7 **大幅增加思考**，token 用量明顯較高 |
| `max` | 真正前沿難題、evals 上限 | 易過度思考、報酬遞減 |

> **IMPORTANT**：官方 default 是 **`high`**（API 與 Claude Code 所有介面一致），**不是** xhigh。
> 編碼/高自主任務請**顯式設 `xhigh`**；它不是預設值。
> **從 4.7 升級**：每級 effort 的 token 配置已**重新校準**（medium↑、high↓、xhigh↑↑），調參前先以同一級**重新建立基準**再微調。
> 跑 `xhigh`/`max` 時把 `max_tokens` 設大（建議 64k 起跳），給模型跨 subagent 與工具呼叫思考的空間。

> **ultracode mode**（Claude Code）：effort 選單中的 ultracode **不是**額外 API effort 級別，而是 `xhigh` + 透過 mid-conversation system message 授予的「常駐多 agent 啟動權限」。

## 2. 自適應思考（Adaptive Thinking）

- Opus 4.8 **只支援 adaptive thinking**，不支援固定 thinking budget（`budget_tokens` 會回 400）。
- 預設**關閉**，需顯式 `thinking: {type: "adaptive"}` 才啟用；模型逐 turn 自行決定是否思考。
- 4.8 在相同 effort 下比 4.7 **更少浪費思考 token**（bimodal 工作負載尤其明顯）。
- **要更多思考**：「Think carefully and step-by-step before responding; this problem is harder than it looks.」
- **要更少思考**：「Prioritize responding quickly rather than thinking deeply. When in doubt, respond directly.」

## 3. 任務規格（task-upfront pattern）

**IMPORTANT**: 把 Opus 4.8 當「資深工程師委派」而非「結對程式設計夥伴」：

- **第一輪就完整交代**：意圖（why）、限制（constraints）、驗收條件（acceptance criteria）、相關檔案路徑（file locations）。
- **批次提問**：每個 user turn 都會增加推理 overhead，避免多輪補充。
- **減少必要互動**：長 session、後期對話 Opus 4.8 會投入更多思考 token — 一次給足 context 才划算。
- **使用 auto mode**（Claude Code Max 透過 `Shift+Tab` 開啟）處理可信任自動執行的長任務。
- **設定完成通知**：請 Claude 建立 hook，任務完成時播放音效。範例（貼到 `.claude/settings.json`）：

  ```json
  "hooks": {
    "Stop": [
      { "matcher": "", "hooks": [{
          "type": "command",
          "command": "afplay /System/Library/Sounds/Glass.aiff 2>/dev/null || paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null || printf '\\a'"
      }] }
    ]
  }
  ```

  macOS 用 `afplay`、Linux 用 `paplay`、其餘 fallback 到終端 bell。Auto Mode 長跑任務時尤其有用。

## 4. 4.8 相對 4.7 的能力改善（官方）

### 4.1 長時 agentic 編碼

- **更佳的 long-context 處理**：長 agentic trace 更不易偏離，**compaction 次數更少**、**compaction 後恢復更好**。
- 官方 evals：4.8 把「自己程式碼留下未標註瑕疵」的機率降到約**4.7 的 1/4**。

### 4.2 Tool triggering 改善（取代舊「工具呼叫較少」caveat）

- 4.7 曾有「該呼叫工具卻略過」的回報；**4.8 已改善**，較不會漏掉任務需要的工具呼叫。
- 因此**不再需要**像 4.7 那樣到處強塞「請積極使用 Grep/Read」；保留必要的明確指示即可，避免過度提示。

### 4.3 Reasoning effort 校準

- 各 effort 級別行為**更可靠**、跨領域一致性更高。
- 若在複雜問題上看到淺層推理：**調高 effort** 而非用 prompt 繞過。

### 4.4 回應長度依任務複雜度校準

- 簡單查詢給短答、開放分析才給長答。
- 如需特定長度/風格：**直接指定**，用「正面範例」優於「負面禁止」。

### 4.5 Subagent spawn 仍偏保守

- 延續 4.7 行為，預設較少自動開 subagent；需要平行委派時**明確寫入 prompt**：
  > 「Do not spawn a subagent for work you can complete directly in a single response. Spawn multiple subagents in the same turn when fanning out across items or reading multiple files.」

## 5. 4.8 新功能（vs 4.7）

| 功能 | 說明 | workspace 影響 |
|------|------|---------------|
| **Mid-conversation system messages** | 允許在 user turn 後插入 `role:"system"` 更新指令，**保留前段 prompt cache hit**、降低 agentic loop 成本；無需 beta header | 可在長 session 中途追加指令而不破壞 cache（見 context-management.md 例外）|
| **Fast mode** | Claude API research preview，`speed:"fast"`，輸出 token/s 最高 **2.5×**，premium 定價 | 對延遲敏感的長輸出任務 |
| **Prompt cache 最低門檻降至 1,024 token** | 比 4.7 更低，原本太短無法 cache 的 prompt 現可建立 cache | 小型 system prompt 也能受惠 cache |
| **Refusal stop_details** | 拒絕回應時 `stop_details` 標示拒絕類別（4.7 起即有，4.8 正式文件化）| 應用層可分流不同拒絕類型 |

## 6. 沿用自 4.7 的限制（不變）

- **不支援 temperature / top_p / top_k**（設非預設值回 400）→ 用 prompting 引導行為。
- **新 tokenizer**（4.7 起）：同段文字 token 數約為舊模型 **1×～1.35×**（最多 +35%），長 session 總 token 可能較高但品質同步提升。

## 7. 推薦的一段式開場範本

```
Task: <一句話描述目標>

Why: <這次修改的商業/技術意圖>

Constraints:
- <限制 1，例如不可改動 public API>
- <限制 2，例如必須向後相容>

Acceptance criteria:
- <可驗證的完成條件 1>
- <可驗證的完成條件 2>

Relevant files:
- <file_path:line>
- <file_path:line>

Execution hints:
- Spawn subagents in parallel when reading >3 independent files.
- Default effort is high; set xhigh explicitly for coding/agentic work.
- Prioritize responding quickly unless a step clearly benefits from deeper thinking.
```

## 參考網址（官方）

- 發布公告：<https://www.anthropic.com/news/claude-opus-4-8>
- What's new in 4.8：<https://platform.claude.com/docs/en/about-claude/models/whats-new-claude-4-8>
- 4.7→4.8 遷移指引：<https://platform.claude.com/docs/en/about-claude/models/migration-guide#migrating-from-claude-opus-47>
- Effort 參數：<https://platform.claude.com/docs/en/build-with-claude/effort>
- Mid-conversation system messages：<https://platform.claude.com/docs/en/build-with-claude/mid-conversation-system-messages>
- Models overview：<https://platform.claude.com/docs/en/about-claude/models/overview>
