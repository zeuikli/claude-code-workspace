#!/bin/bash
set -e

# ============================================
# Claude Code Workspace — SessionStart Hook
# 本機 + 雲端通用：確保每次 session 載入最新指令
# v4: 移除 Memory.md 引用（改由官方 Auto Memory 管理）
#     保留 5MB threshold 智能判斷 partial clone
#
# Ref:
#   - Hooks 事件: https://code.claude.com/docs/en/hooks
#   - Auto Memory: https://code.claude.com/docs/en/memory
#   - 詳細對照: .claude/REFERENCES.md
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
    return 1
  fi
}

INIT_START=$(_ms_now)

# --- 判斷環境 ---
if [ "$CLAUDE_CODE_REMOTE" = "true" ]; then
  TARGET_DIR="$CLOUD_CONFIG_DIR"

  FETCH_START=$(_ms_now)
  if [ -d "$TARGET_DIR/.git" ]; then
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
    git clone --quiet --depth 1 --no-tags "$CONFIG_REPO" "$TARGET_DIR" 2>/dev/null || true
    FETCH_MODE="clone+shallow"
  fi
  FETCH_END=$(_ms_now)
  FETCH_ELAPSED=$(( FETCH_END - FETCH_START ))

  # 建立全域 CLAUDE.md（僅引用 CLAUDE.md，Memory 由官方 Auto Memory 管理）
  mkdir -p ~/.claude
  cat > ~/.claude/CLAUDE.md << EOF
@${TARGET_DIR}/CLAUDE.md
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

  # 確保全域 CLAUDE.md 存在（僅引用 CLAUDE.md，Memory 由官方 Auto Memory 管理）
  mkdir -p ~/.claude
  if [ ! -f ~/.claude/CLAUDE.md ] || ! grep -q "claude-code-workspace/CLAUDE.md" ~/.claude/CLAUDE.md 2>/dev/null; then
    cat > ~/.claude/CLAUDE.md << EOF
@~/claude-code-workspace/CLAUDE.md
EOF
    echo "[session-init] Local: created ~/.claude/CLAUDE.md"
  fi
fi

exit 0
