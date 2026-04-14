#!/bin/bash
# ============================================
# Claude Code Workspace — UserPromptSubmit Hook
# 使用者每次按 Enter 時觸發
# 用途：注入 Memory.md 最新摘要 / 提醒 sub agent 委派
#
# Ref:
#   - Hooks 事件清單（含 UserPromptSubmit）: https://code.claude.com/docs/en/hooks
#   - hookSpecificOutput 格式: https://code.claude.com/docs/en/hooks#json-output
#   - 詳細對照: .claude/REFERENCES.md
# ============================================

LOG_FILE="$HOME/.claude/user-prompts.log"
mkdir -p "$(dirname "$LOG_FILE")"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] prompt submitted" >> "$LOG_FILE"

# 自動截斷至 200 行
if [ -f "$LOG_FILE" ] && [ "$(wc -l < "$LOG_FILE")" -gt 200 ]; then
  tail -n 200 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
fi

# 注入提醒：優先用 Sub Agent
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"💡 提醒：依 CLAUDE.md，研究/實作/測試任務優先委派 Sub Agent（researcher/implementer/test-writer）。Commit 前跑 /deep-review。"}}
JSON

exit 0
