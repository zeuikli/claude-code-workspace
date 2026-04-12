# CHANGELOG

所有重要變更皆記錄於此文件。

---

## 2026-04-12 (2)

### 新增
- `.claude/hooks/session-init.sh` — SessionStart Hook，雲端 session 啟動時自動 clone repo 並建立全域 CLAUDE.md
- `.claude/settings.json` — Hook 設定檔，註冊 SessionStart 事件

### 更新
- `README.md` — 新增本機端與雲端 / 手機的完整設定指引，更新檔案結構圖

---

## 2026-04-12

### 新增
- `CLAUDE.md` — 專案指令檔，包含語言規則、Sub Agent 策略、Context Window 管理、Git 工作流程、驗證與品質指引
- `Memory.md` — 對話記憶檔，用於跨對話上下文保存
- `CHANGELOG.md` — 變更紀錄檔

### 優化
- 根據 Claude Code 官方最佳實踐全面重構 CLAUDE.md：
  - 精簡內容，移除 Claude 已知的通用慣例
  - 使用 `IMPORTANT` / `YOU MUST` 強調關鍵規則
  - 新增 compaction 指引，確保壓縮時保留關鍵資訊
  - 新增驗證與品質區塊
  - 新增 `@` 引用語法連結相關文件
  - Git 工作流程細化，加入重試機制與安全提醒
