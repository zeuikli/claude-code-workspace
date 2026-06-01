---
description: Sub Agent 進階：Opus 4.8 行為差異 + Tasks 跨 session + 工具使用引導
tier: on-demand
triggers: ["Tasks", "Opus 調校", "多 Agent 協調", "跨 session", "subagent 平行化"]
---

# Sub Agent 進階策略

## Opus 4.8 的 subagent 行為差異

- **IMPORTANT**: Opus 4.8 延續 4.7，預設**較少自動開 subagent**，需要平行化時**必須明確指示**，否則會傾向直接在主對話解決。
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

## 工具使用引導（Opus 4.8）

Opus 4.8 官方已**改善 tool triggering**（較不會漏掉任務需要的工具呼叫，修正 4.7 的回報問題）。因此**不需**像 4.7 那樣到處強塞「請積極使用工具」；保留必要的明確指示即可，避免過度提示。

仍需嚴格驗證時（如疑難除錯）再加：

```
每個假設應由 Grep / Read 工具呼叫驗證而非直接推斷。
```

> 來源：[What's new in Opus 4.8](https://platform.claude.com/docs/en/about-claude/models/whats-new-claude-4-8)（Better tool triggering）。

## API 層 Advisor 工具

API 層可使用 `advisor_20260301` 工具實現單次請求內的 Sonnet→Opus 升級（見 `docs/advisor-strategy.md`）。
