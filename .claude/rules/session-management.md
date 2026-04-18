---
description: Session 管理 — 1M context / rewind / compact / clear 決策表
tier: ondemand
source: "https://claude.com/blog/using-claude-code-session-management-and-1m-context (archive: archive/articles/using-claude-code-session-management-and-1m-context.md)"
---

# Session 管理與 1M Context

## 每個 turn 都是分支點（branching point）

完成一輪後，你有 6 個選擇：

1. **Continue** — 同 session 繼續（預設）
2. **`/rewind`**（`Esc Esc`）— 跳回之前某個訊息重新 prompt（丟棄之後的訊息）
3. **`/clear`** — 開新 session，用精煉過的摘要重新開始
4. **`/compact`** — 保留摘要、繼續在同一 session 工作
5. **Subagent** — 把下一塊工作委派給 child context，只拿結論回來
6. **Side chat**（Desktop：`⌘+;` / `Ctrl+;`）— 從當前對話分岔出一條副線問問題；side chat 會讀入主線 context，但**不會回寫到主線**，避免影響當前任務方向

## 決策表（Anthropic 官方建議）

| 情境 | 使用 | 原因 |
|------|------|------|
| 同一任務、context 仍相關 | Continue | 所有內容仍 load-bearing，不要白花錢重建 |
| Claude 走錯路徑 | **Rewind**（double-Esc） | 保留有用的檔案讀取、丟掉失敗嘗試、重新 prompt |
| 任務未完但 session 塞滿 stale debug/探索 | `/compact <hint>` | 低成本、Claude 決定保留什麼；用 hint 引導 |
| 開始**全新任務** | `/clear` | 零 rot，你控制攜帶什麼進入新 context |
| 下一步會產生大量中間輸出、只需結論 | Subagent | 中間 tool noise 留在 child context |

## 關鍵原則

### 1. 新任務 = 新 session

- 即使有 1M context，**新任務就開新 session** 是通則。
- 例外：寫剛實作功能的文件 — 檔案內容還在 context，重新讀較慢且較貴。

### 2. Rewind > 口頭修正

**情境**：Claude 讀了 5 個檔案、嘗試某方法失敗。

- ❌ 較差：「那個沒用，試 X」（失敗嘗試仍留在 context 污染後續）
- ✅ 較佳：**Rewind** 到讀完檔案後，用新學到的重新 prompt：「別用 A 方法，foo module 不提供；直接走 B」
- 延伸：用 `/rewind` 請 Claude **總結發現做 handoff message**，像是給「過去那個嘗試失敗的自己」的提醒。

### 3. Compact vs Clear

| | `/compact` | `/clear` |
|---|-----------|---------|
| 誰寫摘要 | Claude 自動 | 你自己寫下什麼重要 |
| 損失 | lossy（可能漏關鍵）| 零 rot |
| 成本 | 低（自動）| 高（人工寫摘要）|
| 可引導 | `/compact focus on X, drop Y` | 完全自控 |

**Compact hint 範本**（複製貼上後修改）：

```
/compact 保留：當前實作進度、已確認的設計決策、待辦清單。
         丟棄：探索過但放棄的方法、冗長的工具輸出、重複的錯誤訊息。
         下一步：繼續實作 <feature>，從 <file:line> 開始。
```

```
/compact focus on the auth refactor decisions and pending TODOs, drop all the grep/read output
```

### 4. 壞 autocompact 的成因

- autocompact 在 context rot 最嚴重時觸發 — 模型此時**最不聰明**。
- 若目前方向與你**下一步想做的事**不一致，摘要常漏掉關鍵檔案。
- **解法**：1M context 給你更多時間，**主動 `/compact` 並附上下一步描述**。

### 5. Subagent 的判斷心智模型

見常駐載入的 `subagent-strategy.md`（委派規則與「Will I need this output again?」心智模型）。

## Context 監控

監控規則見常駐載入的 `context-management.md`（`/usage`、70% 提醒）。
- 1M context 消除了 compaction 的時間壓力，但 **context rot 仍會發生** — 注意力被稀釋、舊的無關內容會干擾當前任務。
- **Context rot 閾值**（Thariq @trq212, 2026-04-16 驗證）：約 **300–400k tokens** 開始影響輸出品質，高度依賴任務，非硬性規則。

## Side Chat（Desktop 專屬的中途提問）

> 來源：[Redesigning Claude Code on desktop for parallel agents](https://claude.com/blog/claude-code-desktop-redesign)
> 📦 離線歸檔：[`archive/articles/claude-code-desktop-redesign.md`](https://github.com/zeuikli/claude-code-workspace/blob/blog-archive/archive/articles/claude-code-desktop-redesign.md)

- **快捷鍵**：`⌘+;`（macOS）/ `Ctrl+;`（Windows/Linux）
- **用途**：主 agent 跑到一半想問「這個 import 是什麼？」、「這段 pattern 是做什麼？」，又不想污染主對話。
- **單向流**：side chat 會**讀入**主對話 context，但**不會寫回**主對話 — 主線任務方向不被干擾。
- **與 subagent 的區別**：subagent 是主動委派、結論會回流；side chat 是使用者發起的探索、完全不回流。
- **視圖模式**（Desktop）：`Verbose` / `Normal` / `Summary` 三種，`⌘+/` 或 `Ctrl+/` 看完整快捷鍵表。

## 與 Auto Memory 的互動

- 官方 Auto Memory 在跨 session 持久化知識（`~/.claude/projects/<project>/memory/`）。
- `/clear` 或 `/compact` 不影響 Auto Memory — 可安心使用。
- 關鍵決策請確保進入 Auto Memory（Claude 通常會自動判斷，可用 `/memory` 編輯）。

## Boris Cherny 驗證技巧（2026-03-30）

> 來源：[shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice)

### `/branch` — Session Forking（分叉探索）

從現有 session 分岔出一條新線，探索不同方案而不污染原線：

```bash
claude --resume <session-id> --fork-session
```

**適用情境**：想試 approach B，但不確定是否比 approach A 更好 — fork 後平行跑，選勝者。

### `/btw` — 非阻塞側邊提問

在 agent 執行任務中途發問，**不中斷當前任務進度**。Agent 完成目前工作後才回應你的問題。

```
/btw 這個函式為什麼要用 async？
```

**與 Side Chat 的差異**：Side Chat（`⌘+;`）是你發起的探索，不回流主線；`/btw` 是插入 agent 的工作隊列，agent 自己決定何時回答。

### `/focus` — 專注模式（隱藏中間輸出）

隱藏所有中間工具呼叫與輸出，只顯示最終結果。適合 Claude 已取得信任、不需要逐步監看的長時間任務。

```
/focus     ← toggle on/off
```

> 來源：Boris Cherny (@bcherny), 2026-04-16

### Recaps — 回到長時間 Session 的快速定位

長時間 session 回來時，Claude 自動顯示簡短摘要：已完成什麼、下一步是什麼。

```
* Cogitated for 6m 27s
* recap: Fixing the post-submit transcript shift bug. Styling-flash shipped as PR #29869.
         Next: need screen recording of remaining horizontal rewrap to target separate cause.
         (disable recaps in /config)
```

在 `/config` 中可關閉。

> 來源：Boris Cherny (@bcherny), 2026-04-16

### 「從這裡總結」— Rewind 前的 Handoff 技巧

Rewind 前，先請 Claude **總結已學到的發現**，產出 handoff message：

```
請用一段話總結你嘗試過的方法和為什麼失敗，讓重新開始的你不會走相同的錯誤路徑。
```

然後 rewind 到讀完檔案後，將這段摘要貼進新 prompt。這是「給過去自己的提醒」技法。

> 來源：Thariq (@trq212), 2026-04-16
