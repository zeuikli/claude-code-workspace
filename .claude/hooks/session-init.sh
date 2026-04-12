#!/bin/bash
set -e

# ============================================
# Claude Code Workspace — SessionStart Hook
# 本機 + 雲端通用：確保每次 session 載入最新指令
# ============================================

CONFIG_REPO="https://github.com/zeuikli/claude-code-workspace.git"
CONFIG_DIR="$HOME/claude-code-workspace"
CLOUD_CONFIG_DIR="/tmp/claude-code-workspace"

# --- 判斷環境 ---
if [ "$CLAUDE_CODE_REMOTE" = "true" ]; then
  # === 雲端環境 ===
  TARGET_DIR="$CLOUD_CONFIG_DIR"

  if [ -d "$TARGET_DIR/.git" ]; then
    git -C "$TARGET_DIR" pull --quiet --rebase origin main 2>/dev/null || true
  else
    git clone --quiet --depth 1 "$CONFIG_REPO" "$TARGET_DIR" 2>/dev/null || true
  fi

  # 建立全域 CLAUDE.md
  mkdir -p ~/.claude
  cat > ~/.claude/CLAUDE.md << EOF
@${TARGET_DIR}/CLAUDE.md
@${TARGET_DIR}/Memory.md
EOF

  echo "[session-init] Cloud: loaded config from $CONFIG_REPO"

else
  # === 本機環境 ===
  TARGET_DIR="$CONFIG_DIR"

  if [ -d "$TARGET_DIR/.git" ]; then
    # 靜默拉取最新版本
    git -C "$TARGET_DIR" fetch --quiet origin main 2>/dev/null || true
    git -C "$TARGET_DIR" reset --quiet --hard origin/main 2>/dev/null || true
    echo "[session-init] Local: pulled latest from $CONFIG_REPO"
  else
    echo "[session-init] Local: workspace repo not found at $TARGET_DIR, skipping"
    exit 0
  fi

  # 確保全域 CLAUDE.md 存在且正確
  mkdir -p ~/.claude
  if [ ! -f ~/.claude/CLAUDE.md ] || ! grep -q "claude-code-workspace/CLAUDE.md" ~/.claude/CLAUDE.md 2>/dev/null; then
    cat > ~/.claude/CLAUDE.md << EOF
@~/claude-code-workspace/CLAUDE.md
@~/claude-code-workspace/Memory.md
EOF
    echo "[session-init] Local: created ~/.claude/CLAUDE.md"
  fi
fi

exit 0
