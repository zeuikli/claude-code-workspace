#!/bin/bash
# ============================================
# Claude Code Workspace — Memory Archive Hook
# 對齊官方 Memory 上限：200 行 / 25KB
# 超過時自動將舊 Session 移至 Memory-archive-YYYY-MM.md
# 主 Memory.md 保留最新 3 個 Session
# ============================================

# 定位 workspace
if [ "$CLAUDE_CODE_REMOTE" = "true" ]; then
  WORKSPACE_DIR="/tmp/claude-code-workspace"
else
  WORKSPACE_DIR="$HOME/claude-code-workspace"
fi

MEMORY_FILE="$WORKSPACE_DIR/Memory.md"
[ ! -f "$MEMORY_FILE" ] && exit 0

# --- 檢查大小 ---
LINE_COUNT=$(wc -l < "$MEMORY_FILE")
BYTE_COUNT=$(wc -c < "$MEMORY_FILE")
LIMIT_LINES=200
LIMIT_BYTES=25600  # 25KB

if [ "$LINE_COUNT" -le "$LIMIT_LINES" ] && [ "$BYTE_COUNT" -le "$LIMIT_BYTES" ]; then
  exit 0
fi

echo "[memory-archive] Memory.md exceeds limit (lines=$LINE_COUNT/$LIMIT_LINES, bytes=$BYTE_COUNT/$LIMIT_BYTES)"

# --- 找出所有 Session 標題行號（## Session N — date）---
ARCHIVE_MONTH=$(date '+%Y-%m')
ARCHIVE_FILE="$WORKSPACE_DIR/Memory-archive-${ARCHIVE_MONTH}.md"

# 取最新 3 個 ## Session 標題的行號
SESSION_LINES=$(grep -n '^## Session' "$MEMORY_FILE" | head -3 | tail -1 | cut -d: -f1)

if [ -z "$SESSION_LINES" ]; then
  echo "[memory-archive] No session structure found, skipping"
  exit 0
fi

# 找到第 4 個 Session 開始行號（要 archive 的起點）
ARCHIVE_START=$(grep -n '^## Session' "$MEMORY_FILE" | sed -n '4p' | cut -d: -f1)

if [ -z "$ARCHIVE_START" ]; then
  echo "[memory-archive] Less than 4 sessions, skipping archive"
  exit 0
fi

# --- 將舊內容追加到 archive ---
ARCHIVE_END=$(wc -l < "$MEMORY_FILE")
{
  echo ""
  echo "<!-- Archived from Memory.md on $(date '+%Y-%m-%d %H:%M') -->"
  echo ""
  sed -n "${ARCHIVE_START},${ARCHIVE_END}p" "$MEMORY_FILE"
} >> "$ARCHIVE_FILE"

# --- 主 Memory.md 只保留前 3 個 Session ---
NEW_END=$((ARCHIVE_START - 1))
head -n "$NEW_END" "$MEMORY_FILE" > "${MEMORY_FILE}.tmp"

# 加 archive 提示
{
  cat "${MEMORY_FILE}.tmp"
  echo ""
  echo "---"
  echo ""
  echo "> 📦 較舊的 Session 已歸檔至 \`$(basename "$ARCHIVE_FILE")\`"
} > "$MEMORY_FILE"

rm -f "${MEMORY_FILE}.tmp"

echo "[memory-archive] Archived $((ARCHIVE_END - ARCHIVE_START + 1)) lines to $(basename "$ARCHIVE_FILE")"
echo "[memory-archive] Memory.md now: $(wc -l < "$MEMORY_FILE") lines / $(wc -c < "$MEMORY_FILE") bytes"

exit 0
