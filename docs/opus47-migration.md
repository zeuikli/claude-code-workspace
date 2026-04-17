# Opus 4.6 → 4.7 遷移指引

> 來源：<https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code>（2026-04-16）
> 適用範圍：本 workspace 從 4.6 升級到 4.7 的具體 diff 與操作清單。

## TL;DR

| 項目 | 4.6 | 4.7 |
|------|-----|-----|
| 預設 effort | `high` | **`xhigh`**（新等級） |
| Thinking | 固定 budget | **自適應（adaptive）**，不再支援 fixed budget |
| 預設 verbosity | 冗長 | 依任務校準 |
| 工具呼叫傾向 | 積極 | 節制（更多推理）|
| Subagent spawn | 自動 | **保守，需明確指示** |
| Tokenizer | 舊 | 更新 — 同文字 token 數不同 |

## 一、設定檔 Diff（`.claude/settings.json`）

```diff
 {
   "autoMemoryEnabled": true,
+  "model": "claude-opus-4-7",
+  "effortLevel": "xhigh",
+  "alwaysThinkingEnabled": false,
+  "advisorModel": "claude-opus-4-7",
   "env": { ... }
 }
```

### 說明

- `model: "claude-opus-4-7"` — 指定預設模型。
- `effortLevel: "xhigh"` — Opus 4.7 推薦預設，若自動升級會自動套用。
- `alwaysThinkingEnabled: false` — Opus 4.7 已內建自適應思考。此旗標設 `true` 不會「強化」思考，反而每輪多付 ~1.5-2k thinking tokens。用 prompt 語意觸發即可（見 opus47-best-practices.md §2）。
- `advisorModel: "claude-opus-4-7"` — server-side advisor 也使用 Opus 4.7，配合 Advisor 模式。

## 二、Prompt 習慣調整

### 2.1 不再 pair-programming，改為「資深工程師委派」

**壞範例（4.6 可用但 4.7 浪費 token）**：

```
幫我改 foo。
> 哪個 foo？
src/foo.ts
> 改什麼？
加錯誤處理
> 什麼錯誤？
...
```

**好範例（4.7 最佳）**：

```
Task: 在 src/foo.ts:42 的 fetchUser() 加入錯誤處理

Why: 目前 500 會讓前端白屏，需轉成 fallback UI

Constraints:
- 不可改 public API signature
- 錯誤訊息要走既有的 logger.error(...)

Acceptance criteria:
- 單元測試覆蓋 5xx / network timeout / malformed JSON 三種路徑
- 錯誤時回傳 {user: null, error: string}

Relevant files:
- src/foo.ts:42
- src/lib/logger.ts
- tests/foo.test.ts
```

### 2.2 控制思考量

- **要更多思考**：「Think carefully and step-by-step before responding; this problem is harder than it looks.」
- **要更少思考**：「Prioritize responding quickly rather than thinking deeply. When in doubt, respond directly.」

### 2.3 強制平行 subagent

Opus 4.7 預設較少自動 fan-out。在 prompt 中加上：

```
Execution hints:
- Spawn multiple subagents in the same turn when fanning out across items or reading multiple files.
- Do not spawn a subagent for work you can complete directly in a single response.
```

### 2.4 期望特定回應長度/風格

不用「不要 XXX」，改用正面範例：

- ❌ 「不要寫太長、不要用 emoji、不要開頭說 ok」
- ✅ 「範本：用 1-2 句話摘要變更 + 1 句話交代下一步。像 git commit message 的口氣。」

## 三、工作流調整

### 3.1 優先使用 `/rewind`

Claude 走錯方向時：

- ❌ 「那個不對，試 X」→ 失敗嘗試仍在 context 污染後續
- ✅ `Esc Esc`（`/rewind`）→ 跳回讀完檔案後那個點，重新 prompt

### 3.2 新任務 = 新 session

即使 1M context 撐得住，開新 session 對 context rot 更友善。

### 3.3 Auto mode（Claude Code Max 限定）

`Shift+Tab` 開啟 auto mode — 處理可信任自動執行的長任務，降低 cycle time。

### 3.4 `/usage` 監控

新 slash command，查看本 session token/cost 用量。70% 提醒建議用此檢查。

## 四、驗證清單

升級後請跑：

```bash
bash scripts/healthcheck.sh  # workspace 完整性
```

並在一個測試 session 驗證：

- [ ] `model` 顯示為 `claude-opus-4-7`（透過 `/usage` 或狀態列）
- [ ] `effortLevel` 為 `xhigh`
- [ ] 第一輪 prompt 後，觀察是否減少了不必要的 user turn
- [ ] 測試平行 subagent 明確指示是否生效

## 五、常見問題

### Q: Opus 4.7 的回覆比 4.6 短很多，看起來少了細節？

A: 這是預期行為（response length calibrated to task complexity）。若需完整分析，明確指定：
> 「請給完整的 root cause 分析（>200 字），涵蓋 why/what/how。」

### Q: 為何 4.7 不主動開 subagent？

A: 預設較節制。在 prompt 裡明確要求（見 2.3）。

### Q: 長 session token 吃很兇？

A: 4.7 在長 session / 後期 user turn 會投入更多 thinking token。對應策略：
- 主動 `/compact`，而非等 autocompact
- 切換到 `high` effort 降低 thinking 量
- 一次給完整規格，減少 user turn 數
