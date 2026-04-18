#!/bin/bash
set -e

# ============================================
# Tips Fetcher — 從 shanraisshan/claude-code-best-practice 同步 tips
# 每日隨 fetch-blog.yml 執行，將 /tips/*.md 歸檔至 archive/tips/
# ============================================

REPO="shanraisshan/claude-code-best-practice"
TIPS_API="https://api.github.com/repos/${REPO}/contents/tips"
RAW_BASE="https://raw.githubusercontent.com/${REPO}/main/tips"
ARCHIVE_DIR="$(cd "$(dirname "$0")/.." && pwd)/archive"
TIPS_DIR="$ARCHIVE_DIR/tips"
TIPS_INDEX="$TIPS_DIR/index.md"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M UTC')

mkdir -p "$TIPS_DIR"

echo "[fetch-tips] Starting tips sync at $TIMESTAMP"

# --- 1. 取得 tips 目錄清單（GitHub API） ---
API_RESP=$(curl -sL --max-time 30 \
  -H "Accept: application/vnd.github+json" \
  "$TIPS_API" 2>/dev/null || echo "")

if [ -z "$API_RESP" ] || echo "$API_RESP" | grep -q '"message"'; then
  echo "[fetch-tips] ERROR: GitHub API failed: $API_RESP"
  exit 1
fi

# 解析所有 .md 檔名（排除 assets）
FILES=$(echo "$API_RESP" | grep -oP '"name":\s*"\K[^"]+\.md' | sort)

if [ -z "$FILES" ]; then
  echo "[fetch-tips] WARN: No .md files found in tips/"
  echo "New: 0"
  exit 0
fi

TOTAL=$(echo "$FILES" | wc -l)
echo "[fetch-tips] Found $TOTAL tip files"

# --- 2. 下載新增或變更的檔案 ---
NEW_COUNT=0
COUNT=0

for FILE in $FILES; do
  COUNT=$((COUNT + 1))
  DEST="$TIPS_DIR/$FILE"

  # 取得遠端 SHA（用於比對是否有更新）
  REMOTE_SHA=$(echo "$API_RESP" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for f in data:
    if f.get('name') == '${FILE}':
        print(f.get('sha', ''))
        break
" 2>/dev/null || echo "")

  # 若本機有同名檔，比對 git blob SHA（git hash-object）
  if [ -f "$DEST" ]; then
    LOCAL_SHA=$(git hash-object "$DEST" 2>/dev/null || echo "none")
    if [ "$LOCAL_SHA" = "$REMOTE_SHA" ] && [ -n "$REMOTE_SHA" ]; then
      echo "[fetch-tips] [$COUNT/$TOTAL] Skip (unchanged): $FILE"
      continue
    fi
  fi

  echo "[fetch-tips] [$COUNT/$TOTAL] Fetching: $FILE"
  if curl -sL --max-time 30 "$RAW_BASE/$FILE" -o "$DEST"; then
    NEW_COUNT=$((NEW_COUNT + 1))
  else
    echo "[fetch-tips] [$COUNT/$TOTAL] WARN: Failed to fetch $FILE"
  fi
  sleep 0.5
done

# --- 3. 更新 tips/index.md ---
echo "[fetch-tips] Updating tips index..."

cat > "$TIPS_INDEX" << EOINDEX
# Claude Code Tips Archive

> 來源：[shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice/tree/main/tips)
> 最後更新：${TIMESTAMP}
> 共 ${TOTAL} 篇 tips，本次新增/更新 ${NEW_COUNT} 篇

| 檔案 | 說明 |
|------|------|
EOINDEX

for FILE in $FILES; do
  DEST="$TIPS_DIR/$FILE"
  if [ -f "$DEST" ]; then
    TITLE=$(head -3 "$DEST" | grep '^#' | head -1 | sed 's/^# //')
    [ -z "$TITLE" ] && TITLE="$FILE"
    SOURCE_URL="https://github.com/${REPO}/blob/main/tips/${FILE}"
    echo "| [${TITLE}](${FILE}) | [原始](${SOURCE_URL}) |" >> "$TIPS_INDEX"
  fi
done

echo "" >> "$TIPS_INDEX"
echo "[fetch-tips] Done. Total: $TOTAL, New: $NEW_COUNT"
