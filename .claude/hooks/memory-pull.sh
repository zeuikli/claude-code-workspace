#!/bin/bash

# ============================================
# Claude Code Workspace — Memory Pull Hook
# PreToolUse (Read): 讀取 Memory.md 前先拉取最新版本
# 確保跨 session 記憶始終為最新
# ============================================

# 讀取 stdin JSON
INPUT=$(cat)

# 取得要讀取的檔案路徑
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"\s*:\s*"[^"]*"' | head -1 | sed 's/.*:.*"\(.*\)"/\1/')

# 只處理 Memory.md
case "$FILE_PATH" in
  */Memory.md) ;;
  *) exit 0 ;;
esac

# 找到 git root
SEARCH_DIR=$(dirname "$FILE_PATH")
WORKSPACE_DIR=""
while [ "$SEARCH_DIR" != "/" ]; do
  if [ -d "$SEARCH_DIR/.git" ]; then
    WORKSPACE_DIR="$SEARCH_DIR"
    break
  fi
  SEARCH_DIR=$(dirname "$SEARCH_DIR")
done

if [ -z "$WORKSPACE_DIR" ] || [ ! -d "$WORKSPACE_DIR/.git" ]; then
  exit 0
fi

cd "$WORKSPACE_DIR"

# 如果本地有未提交的 Memory.md 變更，保留本地版本（較新）
if ! git diff --quiet Memory.md 2>/dev/null; then
  exit 0
fi

# 從 origin 拉取最新的 Memory.md（僅更新此檔案，不影響其他檔案）
git fetch --quiet origin main 2>/dev/null || exit 0
git checkout origin/main -- Memory.md 2>/dev/null || exit 0

exit 0
