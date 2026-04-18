---
description: Sub Agent 進階：Opus 4.7 行為差異 + Tasks 跨 session + 工具使用引導
tier: on-demand
triggers: ["Tasks", "Opus 調校", "多 Agent 協調", "跨 session", "subagent 平行化"]
---

# Sub Agent 進階策略

## Opus 4.7 的 subagent 行為差異

- **IMPORTANT**: Opus 4.7 預設**較少自動開 subagent**，需要平行化時**必須明確指示**，否則會傾向直接在主對話解決。
- 判斷原則（Anthropic 官方心智模型）：
  > **Will I need this tool output again, or just the conclusion?**
  - 只需要結論 → 委派 subagent（中間產物留在 child context）
  - 需要反覆檢視中間產物 → 主對話自己做
- 建議的明確指示語：
  > 「Spawn multiple subagents in the same turn when fanning out across items or reading multiple files. Do not spawn a subagent for work you can complete directly in a single response.」

## Tasks — 跨 Session 協作的任務原語（Thariq @trq212 驗證）

> Todos → Tasks 升級（2026-03-25）。Tasks 是 Claude Code 追蹤複雜專案的新 primitive。

**與 Todos 的差異**：

| | Todos（舊）| Tasks（新）|
|---|-----------|-----------|
| 儲存位置 | Session 記憶體 | `~/.claude/tasks`（磁碟持久化）|
| 跨 session | ❌ | ✅ |
| Subagent 協作 | ❌ | ✅ 多個 subagent 同時更新同一 task |
| 依賴關係 | ❌ | ✅ Task 可以有 dependencies |
| 跨 session 廣播 | ❌ | ✅ 一個 session 更新，其他 session 即時感知 |

**使用時機**：
- 跨越多個 session 的長任務
- 多個 subagent 需要協調的複雜工作（Task 作為共享狀態）
- 需要 Coordinator 追蹤多個 Worker 進度時

**立即使用**：直接請 Claude 建立 Tasks — 特別適合啟動 subagent 時：
```
請建立 Tasks 追蹤以下子任務，並 fan-out 給各個 subagent...
```

## 工具使用引導（Opus 4.7 每輪適用）

Opus 4.7 **預設工具呼叫次數較少**。agentic 作業時明確要求積極驗證：

```
積極使用 Grep 和 Read 確認現有程式碼，每個假設應由工具呼叫驗證而非直接推斷。
```

## API 層 Advisor 工具

API 層可使用 `advisor_20260301` 工具實現單次請求內的 Sonnet→Opus 升級（見 `docs/advisor-strategy.md`）。
