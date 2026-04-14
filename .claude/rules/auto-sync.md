---
description: Hook 自動化同步機制 — SessionStart / PreToolUse / PostToolUse / Compact
---

# 自動化同步機制

- **SessionStart Hook**: 每次 session 啟動時自動拉取最新的 CLAUDE.md 與 Memory.md（本機 git fetch+reset / 雲端 git clone）。
- **PreToolUse Hook**: 讀取 Memory.md 前自動從 GitHub 拉取最新版本，並透過 JSON `additionalContext` 注入摘要。
- **PostToolUse Hook**: 偵測 Memory.md 被寫入後，自動 commit 並推送回 GitHub（含 30 秒節流避免 race condition）。
- **PreCompact / PostCompact Hook**: 對話壓縮前後自動更新 Memory.md，確保 context 不流失。
- **InstructionsLoaded Hook**: 紀錄 CLAUDE.md 與 rules 載入時機到 `~/.claude/instructions-load.log`，便於除錯。
- **IMPORTANT**: Memory.md 的 git 操作（add / commit / push）由 Hook 自動處理，**不需要手動執行**。
- **跨專案共用**: 其他專案只需在 `.claude/settings.json` 加入相同的 SessionStart Hook，即可自動載入此 workspace 的設定。
