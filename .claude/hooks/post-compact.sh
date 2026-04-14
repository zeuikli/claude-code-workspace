#!/bin/bash
# ============================================
# Claude Code Workspace — PostCompact Hook
# 對話壓縮後提示從 Auto Memory 恢復 context
#
# Ref:
#   - Hooks PostCompact 事件: https://code.claude.com/docs/en/hooks
#   - Auto Memory: https://code.claude.com/docs/en/memory
#   - 詳細對照: .claude/REFERENCES.md
# ============================================

LOG_FILE="$HOME/.claude/compact-events.log"
mkdir -p "$(dirname "$LOG_FILE")"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] PostCompact triggered" >> "$LOG_FILE"

cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"PostCompact","additionalContext":"📋 對話已壓縮 — 使用 /memory 查看 Auto Memory 恢復關鍵上下文，並用 TodoWrite 重建未完成的 Todo 清單。"}}
JSON

exit 0
