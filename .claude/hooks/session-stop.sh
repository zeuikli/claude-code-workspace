#!/bin/bash

# ============================================
# Claude Code Workspace — Session Stop Hook
# Stop: session 結束時自動觸發 Memory.md 同步
# 確保每次對話結束後記憶都備份到 GitHub
# ============================================

# 判斷環境
if [ "$CLAUDE_CODE_REMOTE" = "true" ]; then
  WORKSPACE_DIR="/tmp/claude-code-workspace"
else
  WORKSPACE_DIR="$HOME/claude-code-workspace"
fi

# 確認 workspace 存在
if [ ! -d "$WORKSPACE_DIR/.git" ]; then
  exit 0
fi

# 觸發 Memory.md 同步（非同步執行，不阻塞 session 關閉）
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$SCRIPT_DIR/memory-sync.sh" ]; then
  bash "$SCRIPT_DIR/memory-sync.sh" &
fi

echo "[session-stop] Memory sync triggered"
exit 0
