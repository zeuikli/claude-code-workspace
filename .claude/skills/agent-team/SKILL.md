---
name: agent-team
description: 啟動 Agent Team 模式，多個 worker 平行處理任務並共享發現。適用於大型重構、codebase 遷移、全面審查。
disable-model-invocation: true
---

# Agent Team — 多 Worker 平行協作

> 依據 [Multi-Agent Coordination Patterns](https://claude.com/blog/multi-agent-coordination-patterns) 的 Agent Teams 模式
> 📦 離線歸檔：[`archive/articles/multi-agent-coordination-patterns.md`](https://github.com/zeuikli/claude-code-workspace/blob/blog-archive/archive/articles/multi-agent-coordination-patterns.md)

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
