#!/bin/bash
# PostToolUse hook — Edit/Write 後自動驗證
# 官方文件：https://code.claude.com/docs/en/hooks

# 從 stdin 取得 hook payload（JSON）
PAYLOAD=$(cat)
FILE=$(echo "$PAYLOAD" | grep -o '"path":"[^"]*"' | head -1 | cut -d'"' -f4)

# 只在有明確檔案路徑時執行
[ -z "$FILE" ] && exit 0

EXT="${FILE##*.}"

case "$EXT" in
  sh)
    bash -n "$FILE" 2>&1 && exit 0 || {
      echo "[post-edit] WARNING: bash syntax error in $FILE" >&2
    }
    ;;
  json)
    python3 -c "import json,sys; json.load(open('$FILE'))" 2>&1 && exit 0 || {
      echo "[post-edit] WARNING: JSON syntax error in $FILE" >&2
    }
    ;;
  py)
    python3 -m py_compile "$FILE" 2>&1 && exit 0 || {
      echo "[post-edit] WARNING: Python syntax error in $FILE" >&2
    }
    ;;
  *)
    # 其他類型不做額外驗證
    exit 0
    ;;
esac

exit 0
