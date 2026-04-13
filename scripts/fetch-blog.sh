#!/bin/bash
set -e

# ============================================
# Claude Blog Fetcher
# 抓取 https://claude.com/blog 的所有文章
# 並以 Markdown 格式歸檔
# ============================================

BLOG_URL="https://claude.com/blog"
ARCHIVE_DIR="$(cd "$(dirname "$0")/.." && pwd)/archive"
INDEX_FILE="$ARCHIVE_DIR/index.md"
DATE=$(date '+%Y-%m-%d')
TIMESTAMP=$(date '+%Y-%m-%d %H:%M UTC')

mkdir -p "$ARCHIVE_DIR/articles"

echo "[fetch-blog] Starting blog fetch at $TIMESTAMP"

# --- 1. 抓取 blog 首頁，提取文章連結 ---
echo "[fetch-blog] Fetching blog index..."
BLOG_HTML=$(curl -sL --max-time 30 "$BLOG_URL" 2>/dev/null || echo "")

if [ -z "$BLOG_HTML" ]; then
  echo "[fetch-blog] ERROR: Failed to fetch blog index"
  exit 1
fi

# 提取所有 /blog/xxx 連結（去重）
LINKS=$(echo "$BLOG_HTML" | grep -oP 'href="/blog/[^"]+' | sed 's/href="//' | sort -u)

if [ -z "$LINKS" ]; then
  echo "[fetch-blog] ERROR: No article links found"
  exit 1
fi

TOTAL=$(echo "$LINKS" | wc -l)
echo "[fetch-blog] Found $TOTAL article links"

# --- 2. 逐篇抓取並轉存 Markdown ---
COUNT=0
NEW_COUNT=0

for LINK in $LINKS; do
  COUNT=$((COUNT + 1))
  SLUG=$(echo "$LINK" | sed 's|/blog/||')
  ARTICLE_FILE="$ARCHIVE_DIR/articles/${SLUG}.md"

  # 已存在則跳過
  if [ -f "$ARTICLE_FILE" ]; then
    echo "[fetch-blog] [$COUNT/$TOTAL] Skip (exists): $SLUG"
    continue
  fi

  FULL_URL="https://claude.com${LINK}"
  echo "[fetch-blog] [$COUNT/$TOTAL] Fetching: $SLUG"

  # 抓取文章 HTML
  ARTICLE_HTML=$(curl -sL --max-time 30 "$FULL_URL" 2>/dev/null || echo "")

  if [ -z "$ARTICLE_HTML" ]; then
    echo "[fetch-blog] [$COUNT/$TOTAL] WARN: Failed to fetch $SLUG"
    continue
  fi

  # 提取標題
  TITLE=$(echo "$ARTICLE_HTML" | grep -oP '<title[^>]*>\K[^<]+' | head -1 | sed 's/ | Claude//;s/ - Claude//')
  [ -z "$TITLE" ] && TITLE="$SLUG"

  # 提取 meta description
  DESC=$(echo "$ARTICLE_HTML" | grep -oP 'meta name="description" content="\K[^"]+' | head -1)

  # 提取文章主體文字（移除 HTML 標籤，保留基本結構）
  BODY=$(echo "$ARTICLE_HTML" \
    | sed -n '/<article\|<main\|class="post\|class="blog\|class="content/,/<\/article>\|<\/main>/p' \
    | sed 's/<h1[^>]*>/\n# /g; s/<h2[^>]*>/\n## /g; s/<h3[^>]*>/\n### /g' \
    | sed 's/<\/h[1-6]>/\n/g' \
    | sed 's/<p[^>]*>/\n/g; s/<\/p>/\n/g' \
    | sed 's/<br[^>]*>/\n/g' \
    | sed 's/<li[^>]*>/\n- /g' \
    | sed 's/<code[^>]*>/`/g; s/<\/code>/`/g' \
    | sed 's/<pre[^>]*>/\n```\n/g; s/<\/pre>/\n```\n/g' \
    | sed 's/<[^>]*>//g' \
    | sed 's/&amp;/\&/g; s/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&#39;/'"'"'/g; s/&nbsp;/ /g' \
    | sed '/^[[:space:]]*$/d' \
    | head -500)

  # 如果 article/main 提取失敗，用全頁 body 降級處理
  if [ -z "$BODY" ] || [ "$(echo "$BODY" | wc -c)" -lt 100 ]; then
    BODY=$(echo "$ARTICLE_HTML" \
      | sed -n '/<body/,/<\/body>/p' \
      | sed 's/<script[^>]*>.*<\/script>//g' \
      | sed 's/<style[^>]*>.*<\/style>//g' \
      | sed 's/<h1[^>]*>/\n# /g; s/<h2[^>]*>/\n## /g; s/<h3[^>]*>/\n### /g' \
      | sed 's/<\/h[1-6]>/\n/g' \
      | sed 's/<p[^>]*>/\n/g; s/<\/p>/\n/g' \
      | sed 's/<li[^>]*>/\n- /g' \
      | sed 's/<[^>]*>//g' \
      | sed 's/&amp;/\&/g; s/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&#39;/'"'"'/g; s/&nbsp;/ /g' \
      | sed '/^[[:space:]]*$/d' \
      | head -500)
  fi

  # 寫入 Markdown 檔案
  cat > "$ARTICLE_FILE" << EOARTICLE
---
title: "${TITLE}"
url: ${FULL_URL}
slug: ${SLUG}
fetched: ${TIMESTAMP}
---

# ${TITLE}

> Source: ${FULL_URL}

${DESC:+> ${DESC}}

${BODY}
EOARTICLE

  NEW_COUNT=$((NEW_COUNT + 1))
  # 避免請求過快
  sleep 1
done

# --- 3. 更新索引檔 ---
echo "[fetch-blog] Updating index..."

cat > "$INDEX_FILE" << EOINDEX
# Claude Blog Archive

> 最後更新：${TIMESTAMP}
> 共 ${TOTAL} 篇文章，本次新增 ${NEW_COUNT} 篇

| 文章 | 連結 |
|------|------|
EOINDEX

for LINK in $LINKS; do
  SLUG=$(echo "$LINK" | sed 's|/blog/||')
  ARTICLE_FILE="$ARCHIVE_DIR/articles/${SLUG}.md"
  if [ -f "$ARTICLE_FILE" ]; then
    TITLE=$(head -5 "$ARTICLE_FILE" | grep '^title:' | sed 's/title: "//;s/"$//')
    [ -z "$TITLE" ] && TITLE="$SLUG"
    echo "| ${TITLE} | [文章](articles/${SLUG}.md) / [原文](https://claude.com${LINK}) |" >> "$INDEX_FILE"
  fi
done

echo "" >> "$INDEX_FILE"
echo "[fetch-blog] Done. Total: $TOTAL, New: $NEW_COUNT"
