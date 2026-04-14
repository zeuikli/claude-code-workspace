#!/bin/bash

# ============================================
# Claude Code Workspace — Memory Pull Hook
# PreToolUse (Read): 讀取 Memory.md 前先拉取最新版本
# v2: 拉取後透過 JSON additionalContext 主動注入摘要
#     減少 Claude 被動讀取 round-trip
#
# Ref:
#   - Hooks PreToolUse: https://code.claude.com/docs/en/hooks
#   - Memory docs: https://code.claude.com/docs/en/memory
#   - 詳細對照: .claude/REFERENCES.md
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

cd "$WORKSPACE_DIR" || exit 0

# 如果本地有未提交的 Memory.md 變更，保留本地版本（較新）
if ! git diff --quiet Memory.md 2>/dev/null; then
  exit 0
fi

# 從 origin 拉取最新的 Memory.md（僅更新此檔案，不影響其他檔案）
git fetch --quiet origin main 2>/dev/null || exit 0
git checkout origin/main -- Memory.md 2>/dev/null || exit 0

# === v2：透過 JSON additionalContext 注入 Memory 摘要 ===
if [ -f "Memory.md" ]; then
  # 取最近 50 行作為摘要（通常涵蓋最新 Session）
  SUMMARY=$(head -n 50 Memory.md 2>/dev/null | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
  if [ -n "$SUMMARY" ]; then
    cat <<JSON
{"hookSpecificOutput":{"hookEventName":"PreToolUse","additionalContext":"📋 Memory.md 已拉取最新版（前 50 行摘要）：\n\n${SUMMARY}\n\n（完整內容請繼續 Read 工具）"}}
JSON
  fi
fi

exit 0
