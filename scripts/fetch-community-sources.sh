#!/bin/bash
set -e

# ============================================
# Community Sources Fetcher
# 抓取社群來源：howborisusesclaudecode.com、thariq.io、
#               code.claude.com/docs（關鍵頁面）、GitHub repos
#
# 注意：X/Twitter 內容（bcherny/trq212）需要認證才能直接抓取，
#         故透過 shanraisshan/claude-code-best-practice 間接收錄
#         （fetch-tips.sh 每日同步）
# ============================================

ARCHIVE_DIR="$(cd "$(dirname "$0")/.." && pwd)/archive"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M UTC')
UA="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120 Safari/537.36"
NEW_COUNT=0
TOTAL_SOURCES=0

mkdir -p "$ARCHIVE_DIR/community"
mkdir -p "$ARCHIVE_DIR/docs/code-claude-com"
mkdir -p "$ARCHIVE_DIR/github-activity"

echo "[fetch-community] Starting at $TIMESTAMP"

# ---- html-to-markdown 轉換（沿用 fetch-blog.sh 版本） ----
html_to_markdown() {
  perl -0777 -pe '
    s{<script\b[^>]*>.*?</script>}{}gs;
    s{<style\b[^>]*>.*?</style>}{}gs;
    s{<noscript\b[^>]*>.*?</noscript>}{}gs;
    s{<!--.*?-->}{}gs;
    s{<head\b[^>]*>.*?</head>}{}gs;
    s{<nav\b[^>]*>.*?</nav>}{}gs;
    s{<footer\b[^>]*>.*?</footer>}{}gs;
    s{<svg\b[^>]*>.*?</svg>}{}gs;
    s{<form\b[^>]*>.*?</form>}{}gs;
    s{<h1\b[^>]*>\s*(.*?)\s*</h1>}{\n# $1\n}gs;
    s{<h2\b[^>]*>\s*(.*?)\s*</h2>}{\n## $1\n}gs;
    s{<h3\b[^>]*>\s*(.*?)\s*</h3>}{\n### $1\n}gs;
    s{<h4\b[^>]*>\s*(.*?)\s*</h4>}{\n#### $1\n}gs;
    s{</?(p|div|section|article|header|main|aside|ul|ol|figure|figcaption|blockquote|table|tr)\b[^>]*>}{\n}gs;
    s{<li\b[^>]*>\s*}{\n- }gs;
    s{</li>}{}gs;
    s{<br\s*/?>}{\n}gs;
    s{<pre\b[^>]*>}{\n```\n}gs;
    s{</pre>}{\n```\n}gs;
    s{<code\b[^>]*>}{`}gs;
    s{</code>}{`}gs;
    s{<[^>]+>}{}gs;
    s{&#x([0-9a-fA-F]+);}{chr(hex($1))}ge;
    s{&#([0-9]+);}{chr($1)}ge;
    s{&amp;}{&}g;
    s{&lt;}{<}g;
    s{&gt;}{>}g;
    s{&quot;}{"}g;
    s{&nbsp;}{ }g;
    s{[ \t]+$}{}gm;
    s{\n{3,}}{\n\n}g;
  '
}

# ---- 通用：抓取 URL 並比對 SHA 決定是否更新 ----
fetch_and_save() {
  local URL="$1"
  local DEST="$2"
  local LABEL="$3"
  local CONVERT="${4:-raw}"  # raw | html2md

  mkdir -p "$(dirname "$DEST")"
  TOTAL_SOURCES=$((TOTAL_SOURCES + 1))

  CONTENT=$(curl -sL --max-time 30 -A "$UA" "$URL" 2>/dev/null || echo "")
  if [ -z "$CONTENT" ]; then
    echo "[fetch-community] WARN: Empty response for $LABEL"
    return 0
  fi

  if [ "$CONVERT" = "html2md" ]; then
    CONTENT=$(echo "$CONTENT" | html_to_markdown)
  fi

  if [ -f "$DEST" ]; then
    LOCAL_SHA=$(git hash-object "$DEST" 2>/dev/null || echo "none")
    REMOTE_SHA=$(printf '%s' "$CONTENT" | git hash-object --stdin 2>/dev/null || echo "new")
    if [ "$LOCAL_SHA" = "$REMOTE_SHA" ]; then
      echo "[fetch-community] Skip (unchanged): $LABEL"
      return 0
    fi
  fi

  printf '%s' "$CONTENT" > "$DEST"
  NEW_COUNT=$((NEW_COUNT + 1))
  echo "[fetch-community] Saved: $LABEL"
  return 0
}

# ============================================
# 1. howborisusesclaudecode.com
# ============================================
echo "[fetch-community] --- howborisusesclaudecode.com ---"
mkdir -p "$ARCHIVE_DIR/community/howborisusesclaudecode"

fetch_and_save \
  "https://howborisusesclaudecode.com/" \
  "$ARCHIVE_DIR/community/howborisusesclaudecode/index.md" \
  "howborisusesclaudecode/index" \
  "html2md"

sleep 1

# ============================================
# 2. thariq.io
# ============================================
echo "[fetch-community] --- thariq.io ---"
mkdir -p "$ARCHIVE_DIR/community/thariq-io"

for PAGE_PATH in "" "writing"; do
  PAGE_FNAME="${PAGE_PATH:-index}.md"
  fetch_and_save \
    "https://thariq.io/${PAGE_PATH}" \
    "$ARCHIVE_DIR/community/thariq-io/${PAGE_FNAME}" \
    "thariq-io/${PAGE_FNAME}" \
    "html2md"
  sleep 1
done

# ============================================
# 3. code.claude.com/docs — llms.txt + 關鍵頁面
# ============================================
echo "[fetch-community] --- code.claude.com/docs ---"

# llms.txt（機器可讀完整頁面清單）
fetch_and_save \
  "https://code.claude.com/docs/llms.txt" \
  "$ARCHIVE_DIR/docs/code-claude-com/llms.txt" \
  "docs/llms.txt" \
  "raw"

sleep 0.5

# 關鍵文件頁面
KEY_PAGES="en/whats-new en/best-practices en/hooks en/routines en/skills en/remote-control en/channels en/ultraplan en/settings en/permissions"

for PAGE in $KEY_PAGES; do
  PAGE_FNAME="$(echo "$PAGE" | tr '/' '-').md"
  fetch_and_save \
    "https://code.claude.com/docs/${PAGE}" \
    "$ARCHIVE_DIR/docs/code-claude-com/${PAGE_FNAME}" \
    "docs/${PAGE_FNAME}" \
    "html2md"
  sleep 0.5
done

# ============================================
# 4. GitHub repos: bcherny + trq212（Claude 相關）
# ============================================
echo "[fetch-community] --- GitHub repos (bcherny / trq212) ---"

for GH_USER in "bcherny" "trq212"; do
  API_URL="https://api.github.com/search/repositories?q=claude+user:${GH_USER}&sort=updated&per_page=20"
  RESP=$(curl -sL --max-time 30 \
    -H "Accept: application/vnd.github+json" \
    "$API_URL" 2>/dev/null || echo "")

  if [ -z "$RESP" ]; then
    echo "[fetch-community] WARN: Empty response for GitHub:${GH_USER}"
    sleep 2
    continue
  fi

  if echo "$RESP" | grep -q '"message".*"API rate limit"'; then
    echo "[fetch-community] WARN: GitHub API rate limited for ${GH_USER}"
    sleep 2
    continue
  fi

  DEST="$ARCHIVE_DIR/github-activity/${GH_USER}-claude-repos.json"
  TOTAL_SOURCES=$((TOTAL_SOURCES + 1))
  if [ -f "$DEST" ]; then
    LOCAL_SHA=$(git hash-object "$DEST" 2>/dev/null || echo "none")
    REMOTE_SHA=$(printf '%s' "$RESP" | git hash-object --stdin 2>/dev/null || echo "new")
    if [ "$LOCAL_SHA" = "$REMOTE_SHA" ]; then
      echo "[fetch-community] Skip (unchanged): ${GH_USER}-claude-repos.json"
    else
      printf '%s' "$RESP" > "$DEST"
      NEW_COUNT=$((NEW_COUNT + 1))
      echo "[fetch-community] Updated: ${GH_USER}-claude-repos.json"
    fi
  else
    printf '%s' "$RESP" > "$DEST"
    NEW_COUNT=$((NEW_COUNT + 1))
    echo "[fetch-community] New: ${GH_USER}-claude-repos.json"
  fi
  sleep 2
done

# ============================================
# 5. community/README.md 索引
# ============================================
cat > "$ARCHIVE_DIR/community/README.md" << EOINDEX
# Community Sources Archive

> 最後更新：${TIMESTAMP}

## 收錄來源

| 來源 | 目錄 | 說明 |
|------|------|------|
| howborisusesclaudecode.com | community/howborisusesclaudecode/ | Boris Cherny tips 整合站 |
| thariq.io | community/thariq-io/ | Thariq Shihpar 個人網站與文章 |
| code.claude.com/docs | docs/code-claude-com/ | 官方 Claude Code 文件（10 個關鍵頁面） |
| GitHub: bcherny | github-activity/bcherny-claude-repos.json | Boris Claude 相關 repo |
| GitHub: trq212 | github-activity/trq212-claude-repos.json | Thariq Claude 相關 repo |
| X/Twitter: bcherny + trq212 | archive/tips/ (via shanraisshan) | 需認證，透過 fetch-tips.sh 收錄 |
| shanraisshan/claude-code-best-practice | archive/tips/ | Boris + Thariq tips 備份 |

## 說明

X/Twitter 內容（site:x.com bcherny, site:x.com trq212）需要認證才能直接抓取，
故透過 shanraisshan/claude-code-best-practice 的 tips 目錄間接收錄（fetch-tips.sh 每日同步）。
EOINDEX

echo "[fetch-community] Done. Sources checked: $TOTAL_SOURCES, New/Updated: $NEW_COUNT"
echo "New: $NEW_COUNT"
