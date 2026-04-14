#!/bin/bash

# ============================================
# Claude Code Workspace — Health Check Script
# 用法: bash scripts/healthcheck.sh
# ============================================

# --- 顏色定義 ---
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RESET='\033[0m'

# --- 計數器 ---
PASS=0
WARN=0
FAIL=0

# --- 工具函式 ---
pass() {
  echo -e "${GREEN}[PASS]${RESET} $1"
  PASS=$((PASS + 1))
}

warn() {
  echo -e "${YELLOW}[WARN]${RESET} $1"
  WARN=$((WARN + 1))
}

fail() {
  echo -e "${RED}[FAIL]${RESET} $1"
  FAIL=$((FAIL + 1))
}

# 找到 workspace root（CLAUDE.md 所在的 git repo 根目錄）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "======================================"
echo " Claude Code Workspace — Health Check"
echo " Workspace: $WORKSPACE_DIR"
echo "======================================"
echo ""

# ============================================================
# 1. .claude/settings.json JSON 合法性
# ============================================================
echo "--- JSON Validation ---"
SETTINGS_FILE="$WORKSPACE_DIR/.claude/settings.json"
if [ ! -f "$SETTINGS_FILE" ]; then
  fail "settings.json 不存在：$SETTINGS_FILE"
else
  if python3 -m json.tool "$SETTINGS_FILE" > /dev/null 2>&1; then
    pass "settings.json 是合法的 JSON"
  else
    fail "settings.json JSON 格式錯誤"
  fi
fi

# ============================================================
# 2. 所有 hooks 語法檢查 (bash -n)
# ============================================================
echo ""
echo "--- Hooks Syntax (bash -n) ---"
HOOKS_DIR="$WORKSPACE_DIR/.claude/hooks"
if [ ! -d "$HOOKS_DIR" ]; then
  fail "hooks 目錄不存在：$HOOKS_DIR"
else
  HOOK_COUNT=0
  for script in "$HOOKS_DIR"/*.sh; do
    [ -f "$script" ] || continue
    HOOK_COUNT=$((HOOK_COUNT + 1))
    name="$(basename "$script")"
    if bash -n "$script" 2>/dev/null; then
      pass "hooks/$name 語法正確"
    else
      fail "hooks/$name 語法錯誤"
    fi
  done
  [ "$HOOK_COUNT" -eq 0 ] && warn "hooks/ 目錄內沒有 .sh 檔案"
fi

# ============================================================
# 3. 所有 hooks 可執行位元 (-x)
# ============================================================
echo ""
echo "--- Hooks Executable Bit ---"
if [ -d "$HOOKS_DIR" ]; then
  HOOK_COUNT=0
  for script in "$HOOKS_DIR"/*.sh; do
    [ -f "$script" ] || continue
    HOOK_COUNT=$((HOOK_COUNT + 1))
    name="$(basename "$script")"
    if [ -x "$script" ]; then
      pass "hooks/$name 可執行"
    else
      warn "hooks/$name 不可執行（缺少 +x）"
    fi
  done
  [ "$HOOK_COUNT" -eq 0 ] && warn "hooks/ 目錄內沒有 .sh 檔案"
fi

# ============================================================
# 4. .claude/agents/*.md frontmatter 完整性 (name, description)
# ============================================================
echo ""
echo "--- Agent Frontmatter (name, description) ---"
AGENTS_DIR="$WORKSPACE_DIR/.claude/agents"
if [ ! -d "$AGENTS_DIR" ]; then
  fail "agents 目錄不存在：$AGENTS_DIR"
else
  AGENT_COUNT=0
  for md in "$AGENTS_DIR"/*.md; do
    [ -f "$md" ] || continue
    AGENT_COUNT=$((AGENT_COUNT + 1))
    name="$(basename "$md")"
    result=$(python3 - "$md" <<'PYEOF'
import sys, re

path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    content = f.read()

match = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
if not match:
    print("NO_FRONTMATTER")
    sys.exit(1)

try:
    import yaml
    fm = yaml.safe_load(match.group(1)) or {}
except Exception as e:
    print(f"YAML_ERROR:{e}")
    sys.exit(1)

missing = [f for f in ["name", "description"] if f not in fm]
if missing:
    print(f"MISSING:{','.join(missing)}")
    sys.exit(1)

print("OK")
sys.exit(0)
PYEOF
    )
    case "$result" in
      OK)
        pass "agents/$name frontmatter 完整"
        ;;
      NO_FRONTMATTER)
        fail "agents/$name 缺少 YAML frontmatter"
        ;;
      YAML_ERROR:*)
        fail "agents/$name YAML 解析錯誤：${result#YAML_ERROR:}"
        ;;
      MISSING:*)
        fail "agents/$name 缺少欄位：${result#MISSING:}"
        ;;
      *)
        fail "agents/$name 未知錯誤：$result"
        ;;
    esac
  done
  [ "$AGENT_COUNT" -eq 0 ] && warn "agents/ 目錄內沒有 .md 檔案"
fi

# ============================================================
# 5. .claude/skills/*/SKILL.md 存在且 frontmatter 完整
# ============================================================
echo ""
echo "--- Skill SKILL.md Frontmatter ---"
SKILLS_DIR="$WORKSPACE_DIR/.claude/skills"
if [ ! -d "$SKILLS_DIR" ]; then
  fail "skills 目錄不存在：$SKILLS_DIR"
else
  SKILL_COUNT=0
  for skill_dir in "$SKILLS_DIR"/*/; do
    [ -d "$skill_dir" ] || continue
    SKILL_COUNT=$((SKILL_COUNT + 1))
    skill_name="$(basename "$skill_dir")"
    skill_md="$skill_dir/SKILL.md"

    if [ ! -f "$skill_md" ]; then
      fail "skills/$skill_name/SKILL.md 不存在"
      continue
    fi

    result=$(python3 - "$skill_md" <<'PYEOF'
import sys, re

path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    content = f.read()

match = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
if not match:
    print("NO_FRONTMATTER")
    sys.exit(1)

try:
    import yaml
    fm = yaml.safe_load(match.group(1)) or {}
except Exception as e:
    print(f"YAML_ERROR:{e}")
    sys.exit(1)

missing = [f for f in ["name", "description"] if f not in fm]
if missing:
    print(f"MISSING:{','.join(missing)}")
    sys.exit(1)

print("OK")
sys.exit(0)
PYEOF
    )
    case "$result" in
      OK)
        pass "skills/$skill_name/SKILL.md frontmatter 完整"
        ;;
      NO_FRONTMATTER)
        fail "skills/$skill_name/SKILL.md 缺少 YAML frontmatter"
        ;;
      YAML_ERROR:*)
        fail "skills/$skill_name/SKILL.md YAML 解析錯誤：${result#YAML_ERROR:}"
        ;;
      MISSING:*)
        fail "skills/$skill_name/SKILL.md 缺少欄位：${result#MISSING:}"
        ;;
      *)
        fail "skills/$skill_name/SKILL.md 未知錯誤：$result"
        ;;
    esac
  done
  [ "$SKILL_COUNT" -eq 0 ] && warn "skills/ 目錄內沒有子目錄"
fi

# ============================================================
# 6. CLAUDE.md 行數警告
# ============================================================
echo ""
echo "--- CLAUDE.md Line Count ---"
CLAUDE_MD="$WORKSPACE_DIR/CLAUDE.md"
if [ ! -f "$CLAUDE_MD" ]; then
  fail "CLAUDE.md 不存在"
else
  LINE_COUNT=$(wc -l < "$CLAUDE_MD")
  if [ "$LINE_COUNT" -gt 100 ]; then
    fail "CLAUDE.md 共 $LINE_COUNT 行（> 100，過長，建議拆分）"
  elif [ "$LINE_COUNT" -gt 50 ]; then
    warn "CLAUDE.md 共 $LINE_COUNT 行（> 50，建議精簡）"
  else
    pass "CLAUDE.md 共 $LINE_COUNT 行（正常）"
  fi
fi

# ============================================================
# 7. Git 設定
# ============================================================
echo ""
echo "--- Git Configuration ---"
cd "$WORKSPACE_DIR" || { fail "無法切換到 workspace 目錄"; }

# 7a. remote 可達
REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
if [ -z "$REMOTE_URL" ]; then
  fail "git remote origin 未設定"
else
  # 嘗試 ls-remote（含 timeout）
  if timeout 10 git ls-remote --exit-code --heads origin > /dev/null 2>&1; then
    pass "git remote origin 可達：$REMOTE_URL"
  else
    warn "git remote origin 無法連線（可能是網路或認證問題）：$REMOTE_URL"
  fi
fi

# 7b. 當前分支
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
if [ "$CURRENT_BRANCH" = "HEAD" ]; then
  warn "目前處於 detached HEAD 狀態"
elif [ "$CURRENT_BRANCH" = "unknown" ]; then
  fail "無法取得當前 git 分支"
else
  pass "當前分支：$CURRENT_BRANCH"
fi

# ============================================================
# 統計結果
# ============================================================
echo ""
echo "======================================"
echo -e " 統計結果：${GREEN}PASS: $PASS${RESET}  ${YELLOW}WARN: $WARN${RESET}  ${RED}FAIL: $FAIL${RESET}"
echo "======================================"

if [ "$FAIL" -gt 0 ]; then
  echo -e "${RED}健康檢查未通過，請修復上述 FAIL 項目。${RESET}"
  exit 1
elif [ "$WARN" -gt 0 ]; then
  echo -e "${YELLOW}健康檢查完成，有 $WARN 個警告項目。${RESET}"
  exit 0
else
  echo -e "${GREEN}所有項目通過！Workspace 狀態良好。${RESET}"
  exit 0
fi
