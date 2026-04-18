---
description: 核心規則 — 語言 / Git / 品質三合一（常駐載入）
tier: auto
---

# 核心規則

## 語言

- **IMPORTANT**: 使用者使用中文時，YOU MUST 回覆**台灣繁體中文**。
- If the user uses English, reply in English.

## Git 工作流程

- **IMPORTANT**: 每次改動完成後，YOU MUST 執行：
  1. `git add <files>`（避免 `-A`，防止加入敏感檔）
  2. `git commit` + 清晰的 message
  3. `git push -u origin <branch>`（失敗重試 4 次，間隔 2s/4s/8s/16s）
- 按需更新 `README.md` / `CHANGELOG.md`。

## 實作前假設顯露（Think Before Coding）

- **IMPORTANT**: 收到實作請求後，**先說出你的理解和假設**，再開始寫程式碼：
  1. 用 1-2 句話複述你對需求的理解（不是重複用戶的話，是你的詮釋）
  2. 列出關鍵假設（例如：「我假設這個函式只在 server side 被呼叫」）
  3. 若有多種合理解釋，**列舉選項讓用戶確認**，而非直接選擇
- **IMPORTANT**: 當有困惑時，**說出來而非盲目推進**（「我不確定 X 是否應該 Y，請確認」）。
- 若用戶明確要求直接實作（「直接做」「不用解釋」），跳過此步驟。

## 驗證與品質

- 程式碼變更後優先執行相關測試或 lint。
- 有測試套件時，先跑**單一相關測試**（避免全套拖慢 loop）。
- **IMPORTANT**: 測試失敗時，**完整貼出錯誤輸出**讓 Claude 自行迭代修正（不要只說「失敗了」）。
- UI 變更嘗試 dev server 或截圖驗證。
- Workspace 完整性檢查：`bash scripts/healthcheck.sh`。
- **IMPORTANT**: Commit 前必跑 `/deep-review`；前端變更套用 `frontend-design` skill。
- 大規模重構或方案不確定時，先按 **`Shift+Tab`** 進入 Plan Mode 規劃，確認後再執行。

> Opus 4.7 努力級別（`low`/`medium`/`high`/`xhigh`/`max`）與自適應思考指引：按需載入 `.claude/rules/opus47-best-practices.md`。
