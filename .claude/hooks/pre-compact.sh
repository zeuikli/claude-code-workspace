#!/bin/bash
# ============================================
# Claude Code Workspace — PreCompact Hook
# 對話壓縮前提醒確認 Auto Memory 記錄
#
# Ref:
#   - Hooks PreCompact 事件: https://code.claude.com/docs/en/hooks
#   - Auto Memory: https://code.claude.com/docs/en/memory
#   - 詳細對照: .claude/REFERENCES.md
# ============================================

LOG_FILE="$HOME/.claude/compact-events.log"
mkdir -p "$(dirname "$LOG_FILE")"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] PreCompact triggered" >> "$LOG_FILE"

# 透過 JSON additionalContext 注入提醒
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"PreCompact","additionalContext":"⚠️ 對話即將壓縮 — 請確認關鍵進度已透過 Auto Memory（/memory）記錄，並確保未完成 Todo 已用 TodoWrite 追蹤。"}}
JSON

exit 0
