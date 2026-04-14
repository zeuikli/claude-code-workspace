#!/bin/bash
# ============================================
# Claude Code Workspace — PreCompact Hook
# 對話壓縮前提醒更新 Memory.md
#
# Ref:
#   - Hooks PreCompact 事件: https://code.claude.com/docs/en/hooks
#   - Context Editing API: https://platform.claude.com/docs/en/build-with-claude/context-editing
#   - 詳細對照: .claude/REFERENCES.md
# ============================================

LOG_FILE="$HOME/.claude/compact-events.log"
mkdir -p "$(dirname "$LOG_FILE")"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] PreCompact triggered" >> "$LOG_FILE"

# 透過 JSON additionalContext 注入提醒
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"PreCompact","additionalContext":"⚠️ 對話即將壓縮 — 請在繼續前更新 Memory.md，記錄：(1) 已修改檔案清單 (2) 未完成 Todo (3) 關鍵決策。確保壓縮後可恢復。"}}
JSON

exit 0
