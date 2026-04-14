#!/bin/bash
# ============================================
# Claude Code Workspace — Stop Hook
# Session 結束時，呼叫 memory-sync.sh 確保 Memory.md 推送回 GitHub
# ============================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -x "$SCRIPT_DIR/memory-sync.sh" ]; then
  bash "$SCRIPT_DIR/memory-sync.sh" 2>&1 | sed 's/^/[session-stop] /'
else
  echo "[session-stop] memory-sync.sh not found, skipping"
fi

exit 0
