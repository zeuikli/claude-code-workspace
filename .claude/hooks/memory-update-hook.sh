#!/bin/bash

# ============================================
# Claude Code Workspace — Memory Update Hook
# PostToolUse: 偵測 Memory.md 被寫入後自動同步
# v2: 加入 30s throttle 防止高頻寫入造成 git race condition
#
# Ref:
#   - Hooks PostToolUse: https://code.claude.com/docs/en/hooks
#   - 詳細對照: .claude/REFERENCES.md
# ============================================

# 讀取 stdin JSON
INPUT=$(cat)

# 從 JSON 中取得檔案路徑
FILE_PATH=$(echo "$INPUT" | grep -o '"filePath"\s*:\s*"[^"]*"' | head -1 | sed 's/.*:.*"\(.*\)"/\1/')

# 檢查是否為 Memory.md
case "$FILE_PATH" in
  *Memory.md)
    # === Throttle 機制 ===
    LOCKFILE="$HOME/.claude/.memory-sync-lockfile"
    THROTTLE_SECS=30
    NOW=$(date +%s)
    mkdir -p "$(dirname "$LOCKFILE")"

    if [ -f "$LOCKFILE" ]; then
      LAST=$(cat "$LOCKFILE" 2>/dev/null || echo 0)
      DIFF=$((NOW - LAST))
      if [ "$DIFF" -lt "$THROTTLE_SECS" ]; then
        echo "[memory-update] throttled (last sync ${DIFF}s ago, < ${THROTTLE_SECS}s), skip"
        exit 0
      fi
    fi
    echo "$NOW" > "$LOCKFILE"

    # 找到 workspace 目錄
    if [ "$CLAUDE_CODE_REMOTE" = "true" ]; then
      WORKSPACE_DIR="/tmp/claude-code-workspace"
    else
      WORKSPACE_DIR="$HOME/claude-code-workspace"
    fi

    # 複製最新的 Memory.md 到 workspace（如果是在其他專案中修改的）
    if [ -f "$FILE_PATH" ] && [ -d "$WORKSPACE_DIR/.git" ]; then
      cp "$FILE_PATH" "$WORKSPACE_DIR/Memory.md" 2>/dev/null || true
    fi

    # 觸發同步
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    bash "$SCRIPT_DIR/memory-sync.sh" &
    ;;
esac

exit 0
