#!/bin/bash
# ============================================
# Workspace Injection Mode Benchmark Runner
# 使用方式：
#   bash benchmarks/run-workspace-benchmark.sh
#   bash benchmarks/run-workspace-benchmark.sh --dry-run
#   bash benchmarks/run-workspace-benchmark.sh --trials 1
# ============================================

set -e
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

echo "=== Workspace Injection Mode Benchmark ==="
echo "Repo: $REPO_DIR"
echo ""

# 確認 Python + 依賴
if ! command -v python3 >/dev/null 2>&1; then
  echo "ERROR: python3 not found"
  exit 1
fi

python3 -c "import anthropic, tiktoken" 2>/dev/null || {
  echo "Installing dependencies..."
  pip install anthropic tiktoken -q
}

# 先跑 dry-run 確認 token 數
echo "--- Dry-run token count ---"
python3 benchmarks/benchmark-injection-modes.py --dry-run
echo ""

# 正式跑（若有 API Key）
if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo "ANTHROPIC_API_KEY not set — skipping live benchmark."
  echo "Set it and re-run to get actual API token measurements."
  exit 0
fi

echo "--- Live benchmark ---"
python3 benchmarks/benchmark-injection-modes.py "$@"
