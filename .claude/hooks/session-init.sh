#!/bin/bash
set -e

# ============================================
# Claude Code Workspace — SessionStart Hook
# 在雲端 session 啟動時自動載入共用指令
# ============================================

CONFIG_REPO="https://github.com/zeuikli/claude-code-workspace.git"
CONFIG_DIR="/tmp/claude-code-workspace"

# 如果已存在則更新，否則 clone
if [ -d "$CONFIG_DIR/.git" ]; then
  git -C "$CONFIG_DIR" pull --quiet origin main 2>/dev/null || true
else
  git clone --quiet "$CONFIG_REPO" "$CONFIG_DIR" 2>/dev/null || true
fi

# 建立 ~/.claude 目錄
mkdir -p ~/.claude

# 建立全域 CLAUDE.md，引用 clone 下來的檔案
cat > ~/.claude/CLAUDE.md << 'EOF'
@/tmp/claude-code-workspace/CLAUDE.md
@/tmp/claude-code-workspace/Memory.md
EOF

echo "[session-init] Workspace config loaded from $CONFIG_REPO"
exit 0
