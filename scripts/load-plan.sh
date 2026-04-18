#!/usr/bin/env bash
# load-plan.sh — 顯示 Workspace 四層載入計畫
# Load Plan — Shows 4-tier workspace loading framework
# 動態解析 CLAUDE.md 的 @-rules 和 .claude/skills/ 的所有 skill

WORKSPACE="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
CLAUDE_MD="$WORKSPACE/CLAUDE.md"
SKILLS_DIR="$WORKSPACE/.claude/skills"
RULES_DIR="$WORKSPACE/.claude/rules"
HOOKS_DIR="$WORKSPACE/.claude/hooks"

# Color codes
BOLD='\033[1m'
DIM='\033[2m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'
RESET='\033[0m'

# Token 估算（近似值：chars / 4）
_est_tokens() {
  local file="$1"
  if [ -f "$file" ]; then
    local chars
    chars=$(wc -c < "$file" 2>/dev/null | tr -d ' ')
    echo $(( chars / 4 ))
  else
    echo 0
  fi
}

echo ""
echo -e "${BOLD}╔══════════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}║        📋  Workspace Load Plan  ·  四層載入框架                  ║${RESET}"
echo -e "${BOLD}╚══════════════════════════════════════════════════════════════════╝${RESET}"
echo ""

# ══════════════════════════════════════════════════════════════
# TIER 1 — 真實載入 | Real-time Load
# SessionStart hook + CLAUDE.md 本體
# ══════════════════════════════════════════════════════════════
echo -e "${BOLD}${RED}🔴 TIER 1 · 真實載入 | Real-time Load${RESET}"
echo -e "${DIM}   每次 session 啟動時執行 · Runs on every session start${RESET}"
echo -e "${DIM}────────────────────────────────────────────────────────────────${RESET}"

# session-init.sh hook
HOOK_FILE="$HOOKS_DIR/session-init.sh"
if [ -f "$HOOK_FILE" ]; then
  hook_lines=$(wc -l < "$HOOK_FILE" | tr -d ' ')
  hook_tokens=$(_est_tokens "$HOOK_FILE")
  printf "  ${RED}%-42s${RESET} ${DIM}%4s 行 · ~%s tok${RESET}\n" ".claude/hooks/session-init.sh (hook)" "$hook_lines" "$hook_tokens"
fi

# CLAUDE.md 本體
if [ -f "$CLAUDE_MD" ]; then
  main_lines=$(wc -l < "$CLAUDE_MD" | tr -d ' ')
  main_tokens=$(_est_tokens "$CLAUDE_MD")
  printf "  ${RED}%-42s${RESET} ${DIM}%4s 行 · ~%s tok${RESET}\n" "CLAUDE.md (instructions root)" "$main_lines" "$main_tokens"
fi
echo -e "  ${DIM}➜ 目的：同步最新設定、建立全域 CLAUDE.md 引用${RESET}"
echo ""

# ══════════════════════════════════════════════════════════════
# TIER 2 — 自動載入 | Auto-loaded
# CLAUDE.md @-import 的常駐規則
# ══════════════════════════════════════════════════════════════
echo -e "${BOLD}${YELLOW}🟡 TIER 2 · 自動載入 | Auto-loaded Rules${RESET}"
echo -e "${DIM}   每次 session 常駐 context · Always in context${RESET}"
echo -e "${DIM}────────────────────────────────────────────────────────────────${RESET}"

total_auto_tokens=0
total_auto_lines=0
while IFS= read -r line; do
  if [[ "$line" =~ ^-\ @(.+\.md)(.*)$ ]]; then
    filepath="${BASH_REMATCH[1]}"
    full_path="$WORKSPACE/$filepath"
    if [ -f "$full_path" ]; then
      lines=$(wc -l < "$full_path" 2>/dev/null | tr -d ' ')
      tokens=$(_est_tokens "$full_path")
      tier_val=$(grep -m1 "^tier:" "$full_path" 2>/dev/null | awk '{print $2}' || echo "")
      if [ "$tier_val" = "auto" ] || [ -z "$tier_val" ]; then
        total_auto_lines=$((total_auto_lines + lines))
        total_auto_tokens=$((total_auto_tokens + tokens))
        printf "  ${YELLOW}%-42s${RESET} ${DIM}%4s 行 · ~%s tok${RESET}\n" "$filepath" "$lines" "$tokens"
      fi
    fi
  fi
done < "$CLAUDE_MD"
echo -e "  ${DIM}──────────────────────────────────────────────────────────────${RESET}"
echo -e "  ${DIM}合計 Auto-loaded: ~$total_auto_lines 行 · ~${total_auto_tokens} tokens / session${RESET}"
echo -e "  ${DIM}➜ 目的：語言偏好、Git 流程、Sub Agent 策略、Context 監控${RESET}"
echo ""

# ══════════════════════════════════════════════════════════════
# TIER 3 — 按需載入 | On-demand
# Skills + lazy-load rules
# ══════════════════════════════════════════════════════════════
echo -e "${BOLD}${GREEN}🟢 TIER 3 · 按需載入 | On-demand Skills & Rules${RESET}"
echo -e "${DIM}   說出觸發詞即載入，不說不佔 context · Load on trigger only${RESET}"
echo -e "${DIM}────────────────────────────────────────────────────────────────${RESET}"

show_skill() {
  local skill="$1"
  local trigger_zh="$2"
  local trigger_en="$3"
  local skill_dir="$SKILLS_DIR/$skill"
  if [ -d "$skill_dir" ] && [ -f "$skill_dir/SKILL.md" ]; then
    local sk_tokens
    sk_tokens=$(_est_tokens "$skill_dir/SKILL.md")
    printf "  ${BLUE}/%-22s${RESET} ${DIM}~%4s tok · %s${RESET}\n" "$skill" "$sk_tokens" "$trigger_zh"
  fi
}

echo ""
echo -e "  ${BOLD}${MAGENTA}🖥  程式開發 | Development${RESET}"
show_skill "debug"            "錯誤調查、測試失敗"                "bug investigation, test failures"
show_skill "perf"             "效能分析、API 超時"                "performance analysis, slow APIs"
show_skill "map"              "大型重構、陌生 codebase"           "refactoring, codebase mapping"
show_skill "deep-review"      "Commit 前審查"                    "pre-commit code review"
show_skill "frontend-design"  "前端 UI 設計"                     "frontend/UI development"

echo ""
echo -e "  ${BOLD}${MAGENTA}📣  行銷策略 | Marketing${RESET}"
show_skill "marketing"        "行銷活動、GTM、競品分析"           "campaigns, GTM, competitive analysis"

echo ""
echo -e "  ${BOLD}${MAGENTA}✍️   文案撰寫 | Content Writing${RESET}"
show_skill "writing"          "文案、SEO、Email、Landing Page"   "copywriting, SEO, email marketing"

echo ""
echo -e "  ${BOLD}${MAGENTA}🔍  研究分析 | Research & Analysis${RESET}"
show_skill "research"         "市場調查、競品、文獻整理"           "market research, competitive intel"
show_skill "research-best-practices" "Claude Code 最佳實踐審計"  "Claude Code best practice audit"

echo ""
echo -e "  ${BOLD}${MAGENTA}📋  專案管理 | Project Management${RESET}"
show_skill "pm"               "Sprint、排程、狀態報告"            "sprint planning, status reports"
show_skill "agent-team"       "多 Agent 平行執行"                "multi-agent parallel orchestration"

echo ""
echo -e "  ${BOLD}${MAGENTA}🔧  Workspace 管理 | Workspace Tools${RESET}"
show_skill "prime"            "冷啟 session、接手陌生 repo"       "cold-start new session"
show_skill "retro"            "Session 回顧、compact 前記錄"      "session retrospective before compact"
show_skill "context-report"   "Session 效率與成本分析"            "session efficiency scoring"
show_skill "add-skill"        "建立新 skill（格式驗證）"           "create new skill with format check"
show_skill "cost-tracker"     "Token / 成本追蹤"                  "token usage and cost tracking"
show_skill "load-plan"        "重新顯示本畫面"                    "show this load plan again"

# 按需規則
echo ""
echo -e "  ${BOLD}${MAGENTA}📖  按需規則 | On-demand Rules${RESET}"
for rule_file in "$RULES_DIR"/*.md; do
  rule_name=$(basename "$rule_file" .md)
  tier_val=$(grep -m1 "^tier:" "$rule_file" 2>/dev/null | awk '{print $2}' || echo "")
  if [ "$tier_val" = "ondemand" ]; then
    rule_tokens=$(_est_tokens "$rule_file")
    desc=$(grep -m1 "^description:" "$rule_file" 2>/dev/null | sed 's/^description:[[:space:]]*//' | cut -c1-50 || echo "")
    printf "  ${CYAN}%-28s${RESET} ${DIM}~%4s tok · %s${RESET}\n" "rules/$rule_name.md" "$rule_tokens" "$desc"
  fi
done
echo ""

# ══════════════════════════════════════════════════════════════
# TIER 4 — 不必載入 | Skip Loading
# ══════════════════════════════════════════════════════════════
echo -e "${BOLD}${DIM}⚪ TIER 4 · 不必載入 | Skip / Archive${RESET}"
echo -e "${DIM}   文件索引 / 歷史報告 / archive — 僅在需要時手動 Read${RESET}"
echo -e "${DIM}   Reference docs / historical reports — read manually only${RESET}"
echo -e "${DIM}────────────────────────────────────────────────────────────────${RESET}"
echo -e "  ${DIM}docs/INDEX.md          ·  進階文件總索引${RESET}"
echo -e "  ${DIM}docs/archive/          ·  歷史報告與舊版分析${RESET}"
echo -e "  ${DIM}docs/advisor-strategy.md  ·  Advisor 模式論述（參考用）${RESET}"
echo -e "  ${DIM}prompts.md             ·  12 則萬用 Prompt 模板（參考用）${RESET}"
echo -e "  ${DIM}➜ 載入這些會增加 context 消耗但不提升日常工作效益${RESET}"
echo ""

# ══════════════════════════════════════════════════════════════
# 快速參考 | Quick Reference
# ══════════════════════════════════════════════════════════════
echo -e "${BOLD}${GREEN}💡 快速參考 | Quick Reference${RESET}"
echo -e "${DIM}────────────────────────────────────────────────────────────────${RESET}"
echo -e "  ${CYAN}/load-plan${RESET}         ${DIM}重新顯示本畫面 · Show this plan${RESET}"
echo -e "  ${CYAN}/usage${RESET}             ${DIM}查看 token 用量 · Check token usage${RESET}"
echo -e "  ${CYAN}/compact <hint>${RESET}    ${DIM}壓縮 context · Compress context${RESET}"
echo -e "  ${CYAN}/memory${RESET}            ${DIM}跨 session 記憶 · Cross-session memory${RESET}"
echo -e "  ${CYAN}/prime${RESET}             ${DIM}冷啟 session · Cold-start orient${RESET}"
echo -e "  ${CYAN}/deep-review${RESET}       ${DIM}Commit 前審查 · Pre-commit review${RESET}"
echo ""
echo -e "  ${DIM}完整 skill 清單：ls .claude/skills/${RESET}"
echo -e "  ${DIM}Full skill list:  ls .claude/skills/${RESET}"
echo -e "  ${DIM}文件索引：docs/INDEX.md${RESET}"
echo ""
