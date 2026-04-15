#!/bin/bash
# Benchmark 啟動腳本 — 安全互動式輸入 API Key
# 使用方式: bash benchmarks/run-benchmark.sh [選項]
# 範例:
#   bash benchmarks/run-benchmark.sh --trials 1 --models haiku
#   bash benchmarks/run-benchmark.sh --trials 2 --models all
#   bash benchmarks/run-benchmark.sh --dry-run

set -e
cd "$(dirname "$0")/.."

# ── 讀取 API Key（隱藏輸入）──────────────────────────────────────────────────
if [ -z "$ANTHROPIC_API_KEY" ]; then
  # 嘗試從 .env.local 讀取
  if [ -f ".env.local" ] && grep -q "ANTHROPIC_API_KEY" ".env.local" 2>/dev/null; then
    export $(grep "^ANTHROPIC_API_KEY=" ".env.local" | head -1)
    echo "[env] Loaded API Key from .env.local"
  else
    echo ""
    echo "請輸入 Anthropic API Key（輸入不顯示，Enter 確認）："
    read -s -p "API Key: " ANTHROPIC_API_KEY
    echo ""
    if [ -z "$ANTHROPIC_API_KEY" ]; then
      echo "ERROR: API Key 不能為空"
      exit 1
    fi
    export ANTHROPIC_API_KEY
  fi
fi

echo "[bench] API Key loaded (${#ANTHROPIC_API_KEY} chars)"
echo "[bench] Working dir: $(pwd)"
echo ""

# ── 執行 benchmark ────────────────────────────────────────────────────────────
exec python3 benchmarks/run-auto-benchmark.py "$@"
