---
description: 驗證與品質 — 測試 / lint / UI 截圖
---

# 驗證與品質

- 每次程式碼變更後，優先執行相關測試或 lint 驗證。
- 若專案有測試套件，優先跑單一相關測試而非全部測試（提升效能）。
- UI 變更時，嘗試截圖比對或啟動 dev server 驗證。
- 推薦：執行 `bash scripts/healthcheck.sh` 快速驗證 workspace 完整性。
