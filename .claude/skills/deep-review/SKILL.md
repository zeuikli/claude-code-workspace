---
name: deep-review
description: 對 staged changes 執行三維度平行審查（安全、效能、風格），合成優先排序的發現摘要。
when_to_use: 使用者執行 git commit / push / merge 前，或明確說「審查」「review」「check」時自動建議；CLAUDE.md 規定 commit 前必跑此 Skill。
allowed-tools: Read, Grep, Glob, Bash(git diff:*), Bash(git log:*), Agent
model: sonnet
effort: high
context: fork
---

# Deep Review — 三維度平行程式碼審查

> **Ref**: Skills frontmatter 完整欄位 — https://code.claude.com/docs/en/skills ｜ 完整對照 `.claude/REFERENCES.md`

## 何時觸發

- `git commit` 之前（已由 `pre-commit-review.sh` hook 提醒）
- `git push` 之前
- PR 開啟前
- 使用者明確說「審查 staged changes」「review」

## 預期輸出

依優先級排序的發現清單：
- 🔴 Critical（必修）→ 🟡 Warning（建議）→ 🔵 Info（可選）
- 每項含 `file:line` 引用 + 具體修復建議
- 三個 sub agent 平行跑，總用時 < 主線單人審查的 1/3

## 使用範例

```
使用者：我準備 commit，請先 deep-review
→ 平行啟動 security-reviewer + performance-reviewer + style-reviewer
→ 各自分析 git diff --staged
→ Coordinator 合併三個結果按優先級排序
→ 輸出統一報告 + 修復建議
```

對目前的 staged changes 執行以下三個平行審查：

## 1. 安全審查
使用 security-reviewer agent，檢查：
- 注入漏洞（SQL、XSS、command injection）
- 認證與授權缺陷
- 敏感資料暴露

## 2. 效能審查
檢查以下效能問題：
- N+1 查詢
- 記憶體洩漏風險
- 阻塞操作（blocking I/O in async context）
- 不必要的重複計算

## 3. 風格審查
檢查一致性：
- 是否遵循專案既有的程式碼風格
- 命名慣例是否統一
- 是否有多餘的程式碼或未使用的 import

## 輸出格式

將三個維度的發現合併為優先排序的清單：
1. 🔴 Critical — 必須修復才能合併
2. 🟡 Warning — 建議修復
3. 🔵 Info — 可選的改善建議

每項包含 `file:line` 引用與修復建議。
