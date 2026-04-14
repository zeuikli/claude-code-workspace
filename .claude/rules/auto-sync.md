---
description: Hook 自動化同步機制 — SessionStart / 9 種事件
---

# 自動化同步機制

- **SessionStart Hook**: 每次 session 啟動時自動拉取最新的 CLAUDE.md（5MB threshold 智能選擇 shallow/filter clone）。
- **跨對話記憶**: 由**官方 Auto Memory** 管理（`autoMemoryEnabled: true`），Claude 自動在 `~/.claude/projects/<project>/memory/` 累積記憶，無需 git push 鏈。
- **PreCompact / PostCompact Hook**: 對話壓縮前後提醒確認 Auto Memory 已記錄關鍵內容。
- **UserPromptSubmit Hook**: 每次 prompt 注入 Sub Agent 委派提醒。
- **SubagentStart / SubagentStop Hook**: 監控 Advisor 策略落實度。
- **InstructionsLoaded Hook**: 紀錄 CLAUDE.md 與 rules 載入時機，便於除錯。
- **跨專案共用**: 其他專案只需在 `.claude/settings.json` 加入相同的 SessionStart Hook 即可。
