#!/bin/bash
# ============================================
# Claude Code Workspace — InstructionsLoaded Hook
# 紀錄 CLAUDE.md / rules 載入時機到 ~/.claude/instructions-load.log
# 用於除錯跨檔案規則衝突與載入時序
# 註：實驗性 Hook，需 Claude Code v2.x+ 支援 InstructionsLoaded 事件
# ============================================

LOG_FILE="$HOME/.claude/instructions-load.log"
mkdir -p "$(dirname "$LOG_FILE")"

# 解析 stdin JSON（若有）
INPUT=$(cat 2>/dev/null || echo '{}')
REASON=$(echo "$INPUT" | grep -o '"reason"\s*:\s*"[^"]*"' | head -1 | sed 's/.*:.*"\(.*\)"/\1/')
[ -z "$REASON" ] && REASON="unknown"

TS=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TS] reason=$REASON cwd=$PWD" >> "$LOG_FILE"

# 自動截斷至 500 行（避免 log 無限增長）
if [ -f "$LOG_FILE" ]; then
  LINES=$(wc -l < "$LOG_FILE")
  if [ "$LINES" -gt 500 ]; then
    tail -n 500 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
  fi
fi

exit 0
