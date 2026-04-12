# Memory.md - 對話記憶

> 此文件用於記錄每次對話的重點摘要，以便在新對話中快速恢復上下文。

---

## Session 1 — 2026-04-12

### 完成事項
- 建立 `CLAUDE.md`，包含語言規則、Sub Agent 策略、Context Window 管理、Git 工作流程等指令
- 根據官方最佳實踐 (https://code.claude.com/docs/en/best-practices) 全面優化 CLAUDE.md
- 建立 `Memory.md`、`CHANGELOG.md`

### 關鍵決策
- CLAUDE.md 以繁體中文撰寫，遵循官方「精簡、可操作、強調重要規則」原則
- 使用 `IMPORTANT` 和 `YOU MUST` 標記關鍵規則以提高遵循率
- 加入 compaction 指引，確保對話壓縮時保留關鍵資訊
- 加入驗證與品質區塊，符合官方「提供驗證機制」建議

### 自動化架構（完成）
- **SessionStart Hook** (`session-init.sh`): 本機 git pull / 雲端 git clone，自動建立 `~/.claude/CLAUDE.md`
- **PreToolUse Hook** (`memory-pull.sh`): 讀取 Memory.md 前從 GitHub 拉取最新版
- **PostToolUse Hook** (`memory-update-hook.sh` → `memory-sync.sh`): Memory.md 修改後自動 commit + push
- 三組 Hook 完整覆蓋 session 生命週期：啟動 → 讀取 → 寫入

### 技術備註
- Git 分支：`claude/update-claude-instructions-N0AZg`
- 所有變更皆 merge 至 `main` 並推送到 GitHub
