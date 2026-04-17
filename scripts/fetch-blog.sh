#!/bin/bash
set -e

# ============================================
# Claude Blog Fetcher（v2 — 修正 script/style 多行濾除、entity、截斷）
# 抓取 https://claude.com/blog 的所有文章並以 Markdown 格式歸檔
# ============================================

BLOG_URL="https://claude.com/blog"
ARCHIVE_DIR="$(cd "$(dirname "$0")/.." && pwd)/archive"
INDEX_FILE="$ARCHIVE_DIR/index.md"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M UTC')
UA="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120 Safari/537.36"

mkdir -p "$ARCHIVE_DIR/articles"

echo "[fetch-blog] Starting blog fetch at $TIMESTAMP"

# --- html-to-markdown 轉換函式（多行安全） ---
# 先用 perl 以 -0777 slurp 整個檔案，移除 script/style/comment/head；
# 再逐段轉 heading / list / block → markdown。
html_to_markdown() {
  perl -0777 -pe '
    # 1) 移除會污染 output 的整段
    s{<script\b[^>]*>.*?</script>}{}gs;
    s{<style\b[^>]*>.*?</style>}{}gs;
    s{<noscript\b[^>]*>.*?</noscript>}{}gs;
    s{<!--.*?-->}{}gs;
    s{<head\b[^>]*>.*?</head>}{}gs;
    s{<nav\b[^>]*>.*?</nav>}{}gs;
    s{<footer\b[^>]*>.*?</footer>}{}gs;
    s{<svg\b[^>]*>.*?</svg>}{}gs;
    s{<form\b[^>]*>.*?</form>}{}gs;

    # 2) headings
    s{<h1\b[^>]*>\s*(.*?)\s*</h1>}{\n# $1\n}gs;
    s{<h2\b[^>]*>\s*(.*?)\s*</h2>}{\n## $1\n}gs;
    s{<h3\b[^>]*>\s*(.*?)\s*</h3>}{\n### $1\n}gs;
    s{<h4\b[^>]*>\s*(.*?)\s*</h4>}{\n#### $1\n}gs;

    # 3) block-level → 換行（保留段落邊界）
    s{</?(p|div|section|article|header|main|aside|ul|ol|figure|figcaption|blockquote|table|tr)\b[^>]*>}{\n}gs;
    s{<li\b[^>]*>\s*}{\n- }gs;
    s{</li>}{}gs;
    s{<br\s*/?>}{\n}gs;

    # 4) inline code / pre
    s{<pre\b[^>]*>}{\n```\n}gs;
    s{</pre>}{\n```\n}gs;
    s{<code\b[^>]*>}{`}gs;
    s{</code>}{`}gs;

    # 5) 剩下所有 tag 刪掉
    s{<[^>]+>}{}gs;

    # 6) HTML entities（含 hex 格式）
    s{&#x([0-9a-fA-F]+);}{chr(hex($1))}ge;
    s{&#([0-9]+);}{chr($1)}ge;
    s{&amp;}{&}g;
    s{&lt;}{<}g;
    s{&gt;}{>}g;
    s{&quot;}{"}g;
    s{&nbsp;}{ }g;
    s{&apos;}{'\''}g;

    # 7) 清理空白：多個換行壓成 2、行尾空白刪掉
    s{[ \t]+$}{}gm;
    s{\n{3,}}{\n\n}g;
  '
}

# --- 1. 抓取 blog 首頁，提取文章連結 ---
echo "[fetch-blog] Fetching blog index..."
BLOG_HTML=$(curl -sL --max-time 30 -A "$UA" "$BLOG_URL" 2>/dev/null || echo "")

if [ -z "$BLOG_HTML" ]; then
  echo "[fetch-blog] ERROR: Failed to fetch blog index"
  exit 1
fi

# 提取所有 /blog/xxx 連結（去重，排除 blog 根路徑）
LINKS=$(echo "$BLOG_HTML" | grep -oP 'href="/blog/[^"#?]+' | sed 's/href="//' | grep -v '^/blog/$' | sort -u)

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

  if [ -f "$ARTICLE_FILE" ]; then
    echo "[fetch-blog] [$COUNT/$TOTAL] Skip (exists): $SLUG"
    continue
  fi

  FULL_URL="https://claude.com${LINK}"
  echo "[fetch-blog] [$COUNT/$TOTAL] Fetching: $SLUG"

  ARTICLE_HTML=$(curl -sL --max-time 30 -A "$UA" "$FULL_URL" 2>/dev/null || echo "")

  if [ -z "$ARTICLE_HTML" ]; then
    echo "[fetch-blog] [$COUNT/$TOTAL] WARN: Failed to fetch $SLUG"
    continue
  fi

  # 提取標題（優先 og:title，其次 <title>）
  TITLE=$(echo "$ARTICLE_HTML" | grep -oP 'property="og:title" content="\K[^"]+' | head -1)
  [ -z "$TITLE" ] && TITLE=$(echo "$ARTICLE_HTML" | grep -oP '<title[^>]*>\K[^<]+' | head -1 | sed 's/ | Claude$//;s/ - Claude$//')
  [ -z "$TITLE" ] && TITLE="$SLUG"

  # 提取 meta description
  DESC=$(echo "$ARTICLE_HTML" | grep -oP 'meta name="description" content="\K[^"]+' | head -1)
  [ -z "$DESC" ] && DESC=$(echo "$ARTICLE_HTML" | grep -oP 'property="og:description" content="\K[^"]+' | head -1)

  # 提取文章主體 — 優先找 <article>...</article>，否則整個 <body>
  BODY_HTML=$(echo "$ARTICLE_HTML" | perl -0777 -ne '
    if (/<article\b[^>]*>(.*?)<\/article>/s) { print $1; }
    elsif (/<main\b[^>]*>(.*?)<\/main>/s) { print $1; }
    elsif (/<body\b[^>]*>(.*?)<\/body>/s) { print $1; }
  ')

  [ -z "$BODY_HTML" ] && BODY_HTML="$ARTICLE_HTML"

  BODY=$(echo "$BODY_HTML" | html_to_markdown | sed '/^[[:space:]]*$/N;/\n[[:space:]]*$/D')

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
