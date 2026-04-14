#!/bin/bash
set -e

# ============================================
# Claude Code Workspace — SessionStart Hook
# 本機 + 雲端通用：確保每次 session 載入最新指令
# ============================================

CONFIG_REPO="https://github.com/zeuikli/claude-code-workspace.git"
CONFIG_DIR="$HOME/claude-code-workspace"
CLOUD_CONFIG_DIR="/tmp/claude-code-workspace"

# --- 自製毫秒計時器 ---
_ms_now() {
  # 優先用 date +%N（nanoseconds），若不支援退而求其次用秒
  if date +%N >/dev/null 2>&1 && [ "$(date +%N)" != "%N" ]; then
    echo $(( $(date +%s%N) / 1000000 ))
  else
    echo $(( $(date +%s) * 1000 ))
  fi
}

INIT_START=$(_ms_now)

# --- 判斷環境 ---
if [ "$CLAUDE_CODE_REMOTE" = "true" ]; then
  # === 雲端環境 ===
  TARGET_DIR="$CLOUD_CONFIG_DIR"

  FETCH_START=$(_ms_now)
  if [ -d "$TARGET_DIR/.git" ]; then
    # 使用 shallow fetch + blob filter 減少傳輸量
    # --filter=blob:none 需 git 2.17+；--no-tags 減少額外物件
    if git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags \
        --filter=blob:none origin main 2>/dev/null; then
      git -C "$TARGET_DIR" reset --quiet --hard FETCH_HEAD 2>/dev/null || true
      FETCH_MODE="fetch+reset"
    else
      # fallback: 舊版 git 不支援 --filter
      git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags origin main 2>/dev/null || true
      git -C "$TARGET_DIR" reset --quiet --hard FETCH_HEAD 2>/dev/null || true
      FETCH_MODE="fetch+reset(no-filter)"
    fi
  else
    git clone --quiet --depth 1 --no-tags "$CONFIG_REPO" "$TARGET_DIR" 2>/dev/null || true
    FETCH_MODE="clone"
  fi
  FETCH_END=$(_ms_now)
  FETCH_ELAPSED=$(( FETCH_END - FETCH_START ))

  # 建立全域 CLAUDE.md
  mkdir -p ~/.claude
  cat > ~/.claude/CLAUDE.md << EOF
@${TARGET_DIR}/CLAUDE.md
@${TARGET_DIR}/Memory.md
EOF

  INIT_END=$(_ms_now)
  TOTAL_ELAPSED=$(( INIT_END - INIT_START ))
  echo "[session-init] Cloud: loaded config from $CONFIG_REPO (mode=$FETCH_MODE)"
  echo "[session-init] elapsed: fetch=${FETCH_ELAPSED}ms total=${TOTAL_ELAPSED}ms"

else
  # === 本機環境 ===
  TARGET_DIR="$CONFIG_DIR"

  if [ -d "$TARGET_DIR/.git" ]; then
    FETCH_START=$(_ms_now)
    # 本機用 fetch + reset --hard origin/main（已有本地 repo，不需 clone）
    git -C "$TARGET_DIR" fetch --quiet origin main 2>/dev/null || true
    git -C "$TARGET_DIR" reset --quiet --hard origin/main 2>/dev/null || true
    FETCH_END=$(_ms_now)
    FETCH_ELAPSED=$(( FETCH_END - FETCH_START ))

    INIT_END=$(_ms_now)
    TOTAL_ELAPSED=$(( INIT_END - INIT_START ))
    echo "[session-init] Local: pulled latest from $CONFIG_REPO"
    echo "[session-init] elapsed: fetch=${FETCH_ELAPSED}ms total=${TOTAL_ELAPSED}ms"
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
