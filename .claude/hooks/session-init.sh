#!/bin/bash
set -e

# ============================================
# Claude Code Workspace — SessionStart Hook
# 本機 + 雲端通用：確保每次 session 載入最新指令
# v5: P2 optimizations
#   - Fetch timestamp cache (skip fetch if < CACHE_TTL seconds old)
#   - Sparse-checkout on initial clone (only .claude/ + root md files)
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
CACHE_TTL=300                 # seconds — skip fetch if last fetch < 5 min ago

# Sparse-checkout paths: only what CLAUDE.md and rules need
SPARSE_PATHS=".claude CLAUDE.md prompts.md"

# --- 自製毫秒計時器 ---
_ms_now() {
  if date +%N >/dev/null 2>&1 && [ "$(date +%N)" != "%N" ]; then
    echo $(( $(date +%s%N) / 1000000 ))
  else
    echo $(( $(date +%s) * 1000 ))
  fi
}

# --- 讀取 fetch 時間戳（秒），若不存在回傳 0 ---
_fetch_ts() {
  local ts_file="$1/.fetch_ts"
  [ -f "$ts_file" ] && cat "$ts_file" 2>/dev/null || echo 0
}

# --- 寫入 fetch 時間戳 ---
_save_fetch_ts() {
  date +%s > "$1/.fetch_ts" 2>/dev/null || true
}

# --- 快取是否仍新鮮 ---
_cache_is_fresh() {
  local target_dir="$1"
  local last_ts
  last_ts=$(_fetch_ts "$target_dir")
  local now
  now=$(date +%s)
  [ $(( now - last_ts )) -lt $CACHE_TTL ]
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

# --- Sparse-checkout clone（只取必要路徑，大幅減少傳輸量）---
_sparse_clone() {
  local repo="$1" target="$2"
  git clone --quiet --depth 1 --no-tags --filter=blob:none --sparse "$repo" "$target" 2>/dev/null \
    || git clone --quiet --depth 1 --no-tags "$repo" "$target" 2>/dev/null \
    || return 1
  # 設定 sparse-checkout 路徑（若 --sparse 成功）
  if git -C "$target" config core.sparseCheckout 2>/dev/null | grep -q true; then
    # shellcheck disable=SC2086
    git -C "$target" sparse-checkout set $SPARSE_PATHS 2>/dev/null || true
  fi
}

# --- DEDUP：寫入全域 stub 或完整引用 ---
_write_global_claude_md() {
  local target_dir="$1"
  mkdir -p ~/.claude
  if [ -n "${CLAUDE_PROJECT_DIR:-}" ] && \
     [ -f "${CLAUDE_PROJECT_DIR}/CLAUDE.md" ] && \
     grep -qF "zeuikli/claude-code-workspace" "${CLAUDE_PROJECT_DIR}/CLAUDE.md" 2>/dev/null; then
    printf "# Global stub — workspace rules auto-loaded from project CLAUDE.md\n# See: %s/CLAUDE.md\n" "$CLAUDE_PROJECT_DIR" > ~/.claude/CLAUDE.md
    echo "[session-init] Workspace project detected — using global stub (prevents double-load)"
    return 0
  fi
  return 1  # caller should write the full reference
}

INIT_START=$(_ms_now)

# ============================================================
# 雲端環境
# ============================================================
if [ "$CLAUDE_CODE_REMOTE" = "true" ]; then
  TARGET_DIR="$CLOUD_CONFIG_DIR"

  FETCH_START=$(_ms_now)
  if [ -d "$TARGET_DIR/.git" ]; then
    # [C-1] 驗證 remote URL，防止 /tmp 固定路徑被挾持為惡意 repo
    actual_remote=$(git -C "$TARGET_DIR" remote get-url origin 2>/dev/null || echo "")
    if [ "$actual_remote" != "$CONFIG_REPO" ]; then
      echo "[session-init] WARNING: remote mismatch ('$actual_remote'), re-cloning" >&2
      rm -rf "$TARGET_DIR"
      _sparse_clone "$CONFIG_REPO" "$TARGET_DIR" \
        || { echo "[session-init] ERROR: clone failed" >&2; exit 1; }
      _save_fetch_ts "$TARGET_DIR"
      FETCH_MODE="clone+sparse"
    elif _cache_is_fresh "$TARGET_DIR"; then
      FETCH_MODE="cached"
      echo "[session-init] Cache hit — skipping fetch (< ${CACHE_TTL}s old)"
    elif _should_use_filter "$TARGET_DIR"; then
      git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags --filter=blob:none origin main 2>/dev/null \
        || git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags origin main 2>/dev/null \
        || echo "[session-init] WARNING: fetch failed, using cached config" >&2
      FETCH_MODE="fetch+filter"
      _save_fetch_ts "$TARGET_DIR"
    else
      git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags origin main 2>/dev/null \
        || echo "[session-init] WARNING: fetch failed, using cached config" >&2
      FETCH_MODE="fetch+shallow"
      _save_fetch_ts "$TARGET_DIR"
    fi

    # Apply fetched changes (skip if cache hit)
    if [ "$FETCH_MODE" != "cached" ]; then
      # [W-4] 雲端環境也保護本地未提交修改
      if git -C "$TARGET_DIR" diff --quiet 2>/dev/null && \
         git -C "$TARGET_DIR" diff --staged --quiet 2>/dev/null; then
        git -C "$TARGET_DIR" reset --quiet --hard FETCH_HEAD 2>/dev/null \
          || echo "[session-init] WARNING: reset --hard failed" >&2
      else
        git -C "$TARGET_DIR" merge --quiet --ff-only FETCH_HEAD 2>/dev/null \
          || echo "[session-init] WARNING: merge failed" >&2
      fi
    fi
  else
    _sparse_clone "$CONFIG_REPO" "$TARGET_DIR" \
      || { echo "[session-init] ERROR: initial clone failed" >&2; exit 1; }
    _save_fetch_ts "$TARGET_DIR"
    FETCH_MODE="clone+sparse"
  fi
  FETCH_END=$(_ms_now)
  FETCH_ELAPSED=$(( FETCH_END - FETCH_START ))

  # [W-3] 記錄實際載入的 commit SHA 供稽核
  FETCHED_SHA=$(git -C "$TARGET_DIR" rev-parse --short HEAD 2>/dev/null || echo "unknown")

  if ! _write_global_claude_md "$TARGET_DIR"; then
    cat > ~/.claude/CLAUDE.md << EOF
@${TARGET_DIR}/CLAUDE.md
EOF
  fi

  INIT_END=$(_ms_now)
  TOTAL_ELAPSED=$(( INIT_END - INIT_START ))
  echo "[session-init] Cloud: loaded config from $CONFIG_REPO (mode=$FETCH_MODE, sha=$FETCHED_SHA)"
  echo "[session-init] elapsed: fetch=${FETCH_ELAPSED}ms total=${TOTAL_ELAPSED}ms"

# ============================================================
# 本機環境
# ============================================================
else
  TARGET_DIR="$CONFIG_DIR"

  if [ -d "$TARGET_DIR/.git" ]; then
    FETCH_START=$(_ms_now)
    if _cache_is_fresh "$TARGET_DIR"; then
      FETCH_MODE="cached"
      echo "[session-init] Local: cache hit — skipping fetch (< ${CACHE_TTL}s old)"
    elif _should_use_filter "$TARGET_DIR"; then
      git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags --filter=blob:none origin main 2>/dev/null || \
        git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags origin main 2>/dev/null || true
      FETCH_MODE="fetch+filter"
      _save_fetch_ts "$TARGET_DIR"
    else
      git -C "$TARGET_DIR" fetch --quiet --depth 1 --no-tags origin main 2>/dev/null || true
      FETCH_MODE="fetch+shallow"
      _save_fetch_ts "$TARGET_DIR"
    fi

    if [ "$FETCH_MODE" != "cached" ]; then
      # 防止覆蓋本地未提交修改
      if git -C "$TARGET_DIR" diff --quiet 2>/dev/null && \
         git -C "$TARGET_DIR" diff --staged --quiet 2>/dev/null; then
        git -C "$TARGET_DIR" reset --quiet --hard FETCH_HEAD 2>/dev/null || true
      else
        git -C "$TARGET_DIR" merge --quiet --ff-only FETCH_HEAD 2>/dev/null || true
      fi
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

  if ! _write_global_claude_md "$TARGET_DIR"; then
    if [ ! -f ~/.claude/CLAUDE.md ] || ! grep -q "claude-code-workspace/CLAUDE.md" ~/.claude/CLAUDE.md 2>/dev/null; then
      cat > ~/.claude/CLAUDE.md << EOF
@~/claude-code-workspace/CLAUDE.md
EOF
      echo "[session-init] Local: created ~/.claude/CLAUDE.md"
    fi
  fi
fi

exit 0
