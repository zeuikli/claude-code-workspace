# Token 效率與 Context 壓縮

> **觸發條件**：Context 使用量接近 40% 以上、執行 `/compact` 或 `/clear` 前、討論 token 用量優化策略時。

## 壓縮層級（Context% → 行動）

| Context % | 層級 | 動作 |
|-----------|------|------|
| 0–40% | Minimal | 完整回應，無限制 |
| 40–70% | Efficient | 聚焦回應，省略鋪陳 |
| 70–85% | Compressed | 主動 `/compact <hint>` 或委派 subagent；使用要點清單而非段落 |
| 85–95% | Critical | 暫停非必要讀取；只輸出最關鍵結論；建議 `/clear` 後開新 session |
| 95%+ | Emergency | 停止所有非必要操作；輸出 handoff message 後立即 `/clear` |

## Context 監控規則

- 用 `/usage` 隨時查看本 session token 用量
- 70% 時**立即通知使用者**，給予 `/compact <hint>` 或 `/clear` 選擇
- `/compact` 必須附帶 hint（保留什麼、丟棄什麼、下一步）

## Compact Hint 模板

```
/compact 保留：<當前任務進度、已確認決策>。
         丟棄：<已放棄的方法、大量工具輸出、重複錯誤>。
         下一步：繼續 <feature>，從 <file:line> 開始。
```

## 自動委派閾值

- 需讀取 10+ 個檔案 → 委派 `researcher` subagent
- 產生大量中間輸出 → 委派 subagent（只拿結論）
- 可拆成 3+ 獨立子任務 → 平行啟動多個 subagent

## 備註

- 1M context window 降低了壓縮時間壓力，但 **context rot 仍然存在**（注意力被稀釋）
- 詳細決策邏輯見：`.claude/rules/session-management.md`
