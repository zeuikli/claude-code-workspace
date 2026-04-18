---
description: Opus 4.7 調校指南 — effort、自適應思考、subagent 行為、tokenizer 變化
tier: ondemand
source: "https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code (archive: archive/articles/best-practices-for-using-claude-opus-4-7-with-claude-code.md)"
---

# Opus 4.7 最佳實踐

## 1. Effort 等級（Opus 4.7 新增 `xhigh`）

| Effort | 適用情境 | 備註 |
|--------|---------|------|
| `low` / `medium` | 成本/延遲敏感、範圍狹窄的任務 | 比 4.6 同 effort 更強、有時更省 token |
| `high` | 平衡智力與成本；同時跑多 session 時的選擇 | 品質下降幅度小 |
| **`xhigh`**（預設） | 多數 agentic 編碼工作、API/schema 設計、legacy 遷移、大型 codebase 審查 | **自主性與智力最佳權衡，不會像 max 在長時間 agentic run 失控爆 token** |
| `max` | 極難問題、evals 測試上限、完全不在乎成本 | 易過度思考，報酬遞減 |

> **從 4.6 升級**：不要直接沿用舊的 effort 設定；在 `xhigh` 試跑再調整。任務中可切換 effort 動態管理 token。

## 2. 自適應思考（Adaptive Thinking）

- Opus 4.7 **不再支援固定 thinking budget**；模型自行決定每步是否思考與思考多久。
- 比 4.6 **更不易過度思考**。
- **要更多思考**：「Think carefully and step-by-step before responding; this problem is harder than it looks.」
- **要更少思考**：「Prioritize responding quickly rather than thinking deeply. When in doubt, respond directly.」

## 3. 任務規格（task-upfront pattern）

**IMPORTANT**: 把 Opus 4.7 當「資深工程師委派」而非「結對程式設計夥伴」：

- **第一輪就完整交代**：意圖（why）、限制（constraints）、驗收條件（acceptance criteria）、相關檔案路徑（file locations）。
- **批次提問**：每個 user turn 都會增加推理 overhead，避免多輪補充。
- **減少必要互動**：長 session、後期對話 Opus 4.7 會投入更多思考 token — 一次給足 context 才划算。
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

## 4. 行為變化（vs Opus 4.6）

### 4.1 回應長度依任務複雜度校準

- Opus 4.7 **不再預設冗長** — 簡單查詢給短答、開放分析才給長答。
- 如需特定長度/風格：**直接指定**，用「正面範例」優於「負面禁止」（positive examples work better than "Don't do this"）。

### 4.2 工具呼叫較少、推理較多

- 多數情境結果更好。
- 需要更積極搜尋/讀檔時，**明確指示**何時、為何要用工具：
  > 「遇到無法直接判斷的 import 時，使用 Grep 搜尋定義。」

### 4.3 Subagent spawn 較保守

- Opus 4.7 **預設較少自動開 subagent**。
- 需要平行委派時，**明確寫入 prompt**，例如：
  > 「Do not spawn a subagent for work you can complete directly in a single response (e.g., refactoring a function you can already see). Spawn multiple subagents in the same turn when fanning out across items or reading multiple files.」

## 5. Tokenizer 與長 session 考量

- Opus 4.7 更新了 tokenizer，**同一段文字的 token 數會與 4.6 不同**。
- 長 session 後期 Opus 4.7 會在 user turn 後進行更多推理 → 長 session 總 token 可能變高但品質同步提升。

## 6. 推薦的一段式開場範本

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
- Use xhigh effort (default). Switch to high if token budget is tight.
- Prioritize responding quickly unless a step clearly benefits from deeper thinking.
```
