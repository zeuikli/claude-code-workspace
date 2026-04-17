---
description: 核心規則 — 語言 / Git / 品質三合一（常駐載入）
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

## 驗證與品質

- 程式碼變更後優先執行相關測試或 lint。
- 有測試套件時，先跑**單一相關測試**（避免全套拖慢 loop）。
- UI 變更嘗試 dev server 或截圖驗證。
- Workspace 完整性檢查：`bash scripts/healthcheck.sh`。
- **IMPORTANT**: Commit 前必跑 `/deep-review`；前端變更套用 `frontend-design` skill。

> Opus 4.7 努力級別（`low`/`medium`/`high`/`xhigh`/`max`）與自適應思考指引：按需載入 `.claude/rules/opus47-best-practices.md`。
