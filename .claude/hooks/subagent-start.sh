#!/bin/bash
# ============================================
# Claude Code Workspace — SubagentStart Hook
# 每次 Lead Agent 啟動 sub agent 時觸發
# 用途：log sub agent 使用模式，監控 Advisor 策略落實度
#
# Ref:
#   - Hooks 事件清單（含 SubagentStart）: https://code.claude.com/docs/en/hooks
#   - Sub-agents 文件: https://code.claude.com/docs/en/sub-agents
#   - 詳細對照: .claude/REFERENCES.md
# ============================================

LOG_FILE="$HOME/.claude/subagent-usage.log"
mkdir -p "$(dirname "$LOG_FILE")"

# 從 stdin 讀取 hook payload
INPUT=$(cat 2>/dev/null || echo "{}")
AGENT_TYPE=$(echo "$INPUT" | grep -o '"subagent_type"\s*:\s*"[^"]*"' | head -1 | sed 's/.*:.*"\(.*\)"/\1/')
AGENT_TYPE="${AGENT_TYPE:-unknown}"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] START subagent_type=$AGENT_TYPE" >> "$LOG_FILE"

# 自動截斷
if [ "$(wc -l < "$LOG_FILE")" -gt 500 ]; then
  tail -n 500 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
fi

exit 0
