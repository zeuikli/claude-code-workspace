#!/bin/bash
# Claude Code Workspace — UserPromptSubmit Hook
# Injects Sub Agent delegation reminder on every prompt.
# Truncation check uses stat(1) O(1) byte-size test instead of wc -l to avoid reading the whole log.

LOG_FILE="$HOME/.claude/user-prompts.log"
LOG_MAX_BYTES=15000  # ~200 lines * 75 bytes

mkdir -p "$(dirname "$LOG_FILE")"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] prompt submitted" >> "$LOG_FILE"

# Truncate only when file exceeds threshold (stat is O(1), no file read)
if [ -f "$LOG_FILE" ]; then
  log_size=$(stat -c%s "$LOG_FILE" 2>/dev/null || stat -f%z "$LOG_FILE" 2>/dev/null || echo 0)
  if [ "$log_size" -gt "$LOG_MAX_BYTES" ]; then
    tail -n 200 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
  fi
fi

cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"💡 提醒：依 CLAUDE.md，研究/實作/測試任務優先委派 Sub Agent（researcher/implementer/test-writer）。Commit 前跑 /deep-review。"}}
JSON

exit 0
