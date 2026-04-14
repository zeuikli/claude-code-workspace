---
name: agent-team
description: 啟動 Agent Team 模式，多個 worker 平行處理任務並共享發現。適用於大型重構、codebase 遷移、全面審查。
when_to_use: 任務涉及 5+ 檔案修改、跨多個獨立模組、或需要平行加速時。使用者明確說「拆給多個 sub agent 平行做」也觸發。
disable-model-invocation: true
allowed-tools: Read, Edit, Write, Bash, Grep, Glob, Agent
model: sonnet
effort: medium
context: fork
---

# Agent Team — 多 Worker 平行協作

## 何時觸發

- 大型重構（涉及 5+ 檔案）
- Codebase 遷移（如 v1 → v2 全面改寫）
- 全面審查（安全 + 效能 + 風格三維度）
- 使用者明確說「多 agent 平行」「拆給 sub agent」

## 預期輸出

- 各 Worker 獨立摘要（每個 200-400 字）
- Coordinator 彙整的「衝突解決報告」
- 最終統一變更清單（含檔案路徑與行數）

## 使用範例

```
使用者：把 src/api/v1/ 全部 30 個檔案遷移到 v2 規範
→ agent-team 觸發
→ Coordinator 拆 5 個 Worker（每人負責 6 個檔案）
→ 平行啟動 5 個 implementer sub agent
→ 等所有 Worker 回報後彙整衝突
→ 產出統一變更摘要
```

> 依據 [Multi-Agent Coordination Patterns](https://claude.com/blog/multi-agent-coordination-patterns) 的 Agent Teams 模式

啟動針對 $ARGUMENTS 的 Agent Team 協作。

## 架構

```
Coordinator（主對話）
├── Worker A — 負責領域 1
├── Worker B — 負責領域 2
└── Worker C — 負責領域 3
```

## 工作流程

1. **分析任務範圍**：理解 $ARGUMENTS 描述的任務
2. **劃分工作區域**：按目錄 / 模組 / 功能拆分，確保無重疊
3. **啟動 Workers**：每個 Worker 使用獨立 Sub Agent，指定：
   - 負責的檔案範圍
   - 具體目標
   - 完成標準
4. **平行執行**：所有 Worker 同時啟動
5. **收集結果**：等待所有 Worker 完成，彙整摘要
6. **衝突解決**：如有跨 Worker 的衝突變更，由 Coordinator 決策
7. **產出報告**：統一的變更摘要 + 修改檔案清單

## Worker 規範

- 每個 Worker 只修改自己負責的檔案
- 不跨區域修改（避免 merge 衝突）
- 完成後回傳：變更摘要 + 修改清單 + 待確認事項

## 終止條件

- 所有 Worker 回報完成
- 或達到時間上限（由使用者指定）
- 或 Coordinator 判斷已收斂（無新發現）
