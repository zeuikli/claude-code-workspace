#!/bin/bash
set -e

# ============================================
# Claude Code Workspace — SessionStart Hook
# 本機 + 雲端通用：確保每次 session 載入最新指令
# v3: 加入 5MB threshold 智能判斷 partial clone
#     - repo > 5MB 才用 --filter=blob:none（協商開銷划算）
#     - repo < 5MB 用傳統 shallow clone（避免協商開銷反拖慢）
# ============================================

CONFIG_REPO="https://github.com/zeuikli/claude-code-workspace.git"
CONFIG_DIR="$HOME/claude-code-workspace"
CLOUD_CONFIG_DIR="/tmp/claude-code-workspace"
SIZE_THRESHOLD_BYTES=5242880  # 5MB

# --- 自製毫秒計時器 ---
_ms_now() {
  if date +%N >/dev/null 2>&1 && [ "$(date +%N)" != "%N" ]; then
    echo $(( $(date +%s%N) / 1000000 ))
  else
    echo $(( $(date +%s) * 1000 ))
  fi
}

# --- 偵測 repo 大小決定是否用 partial clone ---
_should_use_filter() {
  local target_dir="$1"
  if [ -d "$target_dir/.git" ]; then
    local size
    size=$(du -sb "$target_dir/.git" 2>/dev/null | awk '{print $1}')
    [ -n "$size" ] && [ "$size" -gt "$SIZE_THRESHOLD_BYTES" ]
  else
    # 無本地 repo，檢查 remote 大小不切實際 → 預設不用 filter
    return 1
  fi
}

INIT_START=$(_ms_now)

# --- 判斷環境 ---
if [ "$CLAUDE_CODE_REMOTE" = "true" ]; then
  TARGET_DIR="$CLOUD_CONFIG_DIR"

  FETCH_START=$(_ms_now)
  if [ -d "$TARGET_DIR/.git" ]; then
    # 智能選擇 filter 策略
    if _should_use_filter "$TARGET_DIR"; then
      git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags --filter=blob:none origin main 2>/dev/null || \
        git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags origin main 2>/dev/null || true
      FETCH_MODE="fetch+filter"
    else
      git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags origin main 2>/dev/null || true
      FETCH_MODE="fetch+shallow"
    fi
    git -C "$TARGET_DIR" reset --quiet --hard FETCH_HEAD 2>/dev/null || true
  else
    # Cold clone：小 repo 不用 filter（協商開銷不划算）
    git clone --quiet --depth 1 --no-tags "$CONFIG_REPO" "$TARGET_DIR" 2>/dev/null || true
    FETCH_MODE="clone+shallow"
  fi
  FETCH_END=$(_ms_now)
  FETCH_ELAPSED=$(( FETCH_END - FETCH_START ))

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
  TARGET_DIR="$CONFIG_DIR"

  if [ -d "$TARGET_DIR/.git" ]; then
    FETCH_START=$(_ms_now)
    if _should_use_filter "$TARGET_DIR"; then
      git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags --filter=blob:none origin main 2>/dev/null || \
        git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags origin main 2>/dev/null || true
      FETCH_MODE="fetch+filter"
    else
      git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags origin main 2>/dev/null || true
      FETCH_MODE="fetch+shallow"
    fi
    # 防止覆蓋本地未提交修改
    if git -C "$TARGET_DIR" diff --quiet 2>/dev/null && \
       git -C "$TARGET_DIR" diff --staged --quiet 2>/dev/null; then
      git -C "$TARGET_DIR" reset --quiet --hard FETCH_HEAD 2>/dev/null || true
    else
      git -C "$TARGET_DIR" merge --quiet --ff-only FETCH_HEAD 2>/dev/null || true
    fi
    FETCH_END=$(_ms_now)
    FETCH_ELAPSED=$(( FETCH_END - FETCH_START ))
    INIT_END=$(_ms_now)
    TOTAL_ELAPSED=$(( INIT_END - INIT_START ))
    echo "[session-init] Local: pulled latest from $CONFIG_REPO (mode=$FETCH_MODE)"
    echo "[session-init] elapsed: fetch=${FETCH_ELAPSED}ms total=${TOTAL_ELAPSED}ms"
  else
    echo "[session-init] Local: workspace repo not found at $TARGET_DIR, skipping"
    exit 0
  fi

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
