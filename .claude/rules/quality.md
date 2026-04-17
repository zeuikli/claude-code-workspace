---
description: 驗證與品質 — 測試 / lint / UI 截圖（含 Opus 4.7 努力級別與自適應思考指引）
---

# 驗證與品質

- 每次程式碼變更後，優先執行相關測試或 lint 驗證。
- 若專案有測試套件，優先跑單一相關測試而非全部測試（提升效能）。
- UI 變更時，嘗試截圖比對或啟動 dev server 驗證。
- 推薦：執行 `bash scripts/healthcheck.sh` 快速驗證 workspace 完整性。

## Opus 4.7 努力級別（Effort Level）指引

> 來源：[Best practices for using Claude Opus 4.7 with Claude Code](https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code)

| 努力級別 | 適用場景 |
|----------|----------|
| `low` / `medium` | 成本敏感、延遲敏感、範疇明確的簡單任務 |
| `high` | 需要平衡智能與成本；同時跑多個 session 時 |
| `xhigh`（**預設，推薦**） | 大多數 coding 與 agentic 任務；自主性強且不會 token 失控 |
| `max` | 極度智能敏感、不計成本的任務（eval 測試、研究性問題） |

**建議**：從 `xhigh` 開始，依實際結果再調整。不要把 Opus 4.6 的 `max` 設定直接搬到 4.7。

## Opus 4.7 自適應思考（Adaptive Thinking）

- Opus 4.7 **不支援固定 thinking budget**，改用自適應思考：模型自行決定每步是否需要深度推理。
- 需要更多推理時，在 prompt 中引導：
  > "Think carefully and step-by-step before responding; this problem is harder than it looks."
- 需要更快回應時：
  > "Prioritize responding quickly rather than thinking deeply. When in doubt, respond directly."
