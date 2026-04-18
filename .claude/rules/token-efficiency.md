# Token 效率與 Context 壓縮

> 按需載入：Context > 70% 或需要優化 token 用量時。

## 壓縮層級

| Context % | 層級 | 動作 |
|-----------|------|------|
| 0–40% | Minimal | 完整回應，無限制 |
| 40–70% | Efficient | 聚焦回應，省略鋪陳與重複說明 |
| 70–85% | Compressed | 主動 `/compact <hint>`；改用要點清單而非段落；委派 subagent 隔離輸出 |
| 85–95% | Critical | 停止非必要讀取；只輸出最關鍵結論；建議 `/clear` 後開新 session |
| 95%+ | Emergency | 停止所有非必要操作；輸出 handoff message 後立即 `/clear` |

## Context 監控

- `/usage` 查看本 session 即時 token 用量
- **70% 時立即通知使用者**，提供三個選項：
  1. `/compact <hint>` — 保留摘要繼續當前任務（低成本）
  2. `/clear` — 切換全新任務時使用
  3. 開新 terminal session — 並行工作流

## Compact Hint 模板

```
/compact 保留：<當前任務進度、已確認的設計決策、待辦清單>。
         丟棄：<已放棄的方法、大量工具輸出、重複錯誤訊息>。
         下一步：繼續 <feature>，從 <file:line> 開始。
```

## 自動委派閾值

- 需讀取 **10+ 個檔案** → 委派 `researcher` subagent（只拿結論）
- 產生**大量中間輸出**（tool noise）→ 委派 subagent
- 可拆成 **3+ 獨立子任務** → 單一訊息平行啟動多個 subagent

## 備註

- 1M context window 降低了壓縮的時間壓力，但 **context rot 仍然存在**（注意力被稀釋、無關內容干擾當前任務）
- 詳細 rewind/compact/clear 決策邏輯：`.claude/rules/session-management.md`
