#!/bin/bash
# ============================================
# Claude Code Workspace — SubagentStop Hook
# Sub agent 結束時觸發
# 用途：配對 start/stop 紀錄，統計 duration
#
# Ref:
#   - Hooks 事件清單（含 SubagentStop）: https://code.claude.com/docs/en/hooks
#   - Sub-agents 文件: https://code.claude.com/docs/en/sub-agents
#   - 詳細對照: .claude/REFERENCES.md
# ============================================

LOG_FILE="$HOME/.claude/subagent-usage.log"
mkdir -p "$(dirname "$LOG_FILE")"

INPUT=$(cat 2>/dev/null || echo "{}")
AGENT_TYPE=$(echo "$INPUT" | grep -o '"subagent_type"\s*:\s*"[^"]*"' | head -1 | sed 's/.*:.*"\(.*\)"/\1/')
AGENT_TYPE="${AGENT_TYPE:-unknown}"
STATUS=$(echo "$INPUT" | grep -o '"status"\s*:\s*"[^"]*"' | head -1 | sed 's/.*:.*"\(.*\)"/\1/')
STATUS="${STATUS:-ok}"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] STOP  subagent_type=$AGENT_TYPE status=$STATUS" >> "$LOG_FILE"

exit 0
