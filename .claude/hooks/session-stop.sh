#!/bin/bash
# ============================================
# Claude Code Workspace — Stop Hook
# Session 結束時記錄日誌
# 記憶由官方 Auto Memory 自動管理，無需手動同步
#
# Ref:
#   - Hooks Stop 事件: https://code.claude.com/docs/en/hooks
#   - Auto Memory: https://code.claude.com/docs/en/memory
#   - 詳細對照: .claude/REFERENCES.md
# ============================================

LOG_FILE="$HOME/.claude/session-events.log"
mkdir -p "$(dirname "$LOG_FILE")"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Session stopped" >> "$LOG_FILE"

echo "[session-stop] Session ended. Auto Memory handles cross-session persistence."
exit 0
