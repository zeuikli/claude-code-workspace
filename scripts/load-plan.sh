#!/usr/bin/env bash
# load-plan.sh — 顯示 workspace 載入計畫
# 動態解析 CLAUDE.md 的 @-rules 和 .claude/skills/ 的所有 skill

WORKSPACE="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
CLAUDE_MD="$WORKSPACE/CLAUDE.md"
SKILLS_DIR="$WORKSPACE/.claude/skills"
RULES_DIR="$WORKSPACE/.claude/rules"

# Color codes
BOLD='\033[1m'
DIM='\033[2m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
RESET='\033[0m'

echo ""
echo -e "${BOLD}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}║              📋  Workspace Load Plan                         ║${RESET}"
echo -e "${BOLD}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo ""

# ── 1. 自動載入規則 ──────────────────────────────────────────
echo -e "${BOLD}${GREEN}📌 自動載入（每次 session 啟動 · 常駐 context）${RESET}"
echo -e "${DIM}─────────────────────────────────────────────────${RESET}"

total_auto_lines=0
while IFS= read -r line; do
    if [[ "$line" =~ ^-\ @(.+\.md)(.*)$ ]]; then
        filepath="${BASH_REMATCH[1]}"
        comment="${BASH_REMATCH[2]}"
        full_path="$WORKSPACE/$filepath"
        if [ -f "$full_path" ]; then
            lines=$(wc -l < "$full_path" 2>/dev/null | tr -d ' ')
            size=$(wc -c < "$full_path" 2>/dev/null | awk '{printf "%.1fKB", $1/1024}')
            total_auto_lines=$((total_auto_lines + lines))
            desc=$(echo "$comment" | sed 's/^[[:space:]]*—[[:space:]]*//' | sed 's/（[^）]*）//' | xargs)
            printf "  ${CYAN}%-38s${RESET} ${DIM}%4s 行 · %s${RESET}\n" "$filepath" "$lines" "$size"
        fi
    fi
done < "$CLAUDE_MD"

echo -e "  ${DIM}──────────────────────────────────────────────────${RESET}"
total_size=$(cat "$WORKSPACE/.claude/rules/core.md" "$WORKSPACE/.claude/rules/subagent-strategy.md" "$WORKSPACE/.claude/rules/context-management.md" 2>/dev/null | wc -c | awk '{printf "%.1fKB", $1/1024}')
echo -e "  ${DIM}合計：約 $total_auto_lines 行 · ~$total_size${RESET}"

# ── 2. 按需 Skill ────────────────────────────────────────────
echo ""
echo -e "${BOLD}${YELLOW}⚡ 按需載入 Skill（說出觸發詞即載入 · 不說不佔 context）${RESET}"
echo -e "${DIM}────────────────────────────────────────────────────────${RESET}"

show_skill() {
    local skill="$1"
    local trigger="$2"
    local skill_dir="$SKILLS_DIR/$skill"
    if [ -d "$skill_dir" ] && [ -f "$skill_dir/SKILL.md" ]; then
        printf "  ${BLUE}/%-22s${RESET} ${DIM}%s${RESET}\n" "$skill" "$trigger"
    fi
}

echo ""
echo -e "  ${BOLD}${MAGENTA}🖥  程式開發${RESET}"
show_skill "debug"           "出現錯誤、測試失敗、生產異常"
show_skill "perf"            "應用程式慢、API 超時"
show_skill "map"             "大型重構前、陌生 codebase"
show_skill "deep-review"     "Commit 前程式碼審查"
show_skill "frontend-design" "前端開發、UI 設計"

echo ""
echo -e "  ${BOLD}${MAGENTA}📣  行銷策略${RESET}"
show_skill "marketing"       "行銷活動、GTM、A/B 測試、競品定位"

echo ""
echo -e "  ${BOLD}${MAGENTA}✍️   文案撰寫${RESET}"
show_skill "writing"         "文案、SEO、Email 行銷、Landing Page"

echo ""
echo -e "  ${BOLD}${MAGENTA}🔍  研究分析${RESET}"
show_skill "research"        "市場調查、競品分析、文獻整理"
show_skill "research-best-practices" "Claude Code best practice 審計"

echo ""
echo -e "  ${BOLD}${MAGENTA}📋  專案管理${RESET}"
show_skill "pm"              "Sprint 規劃、優先排序、狀態報告"
show_skill "agent-team"      "大型任務多 Agent 平行執行"

echo ""
echo -e "  ${BOLD}${MAGENTA}🔧  Workspace 管理${RESET}"
show_skill "prime"           "冷啟 session、接手陌生 codebase"
show_skill "retro"           "Session 回顧、compact 前決策記錄"
show_skill "context-report"  "Session 效率分析、成本評估"
show_skill "add-skill"       "建立新 skill（格式驗證）"

# ── 3. 快速參考 ───────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}💡 快速參考${RESET}"
echo -e "${DIM}─────────────────────────────────────────────────${RESET}"
echo -e "  ${CYAN}/load-plan${RESET}       ${DIM}重新顯示本畫面${RESET}"
echo -e "  ${CYAN}/usage${RESET}           ${DIM}查看本 session token 用量${RESET}"
echo -e "  ${CYAN}/compact${RESET}         ${DIM}壓縮 context 並繼續${RESET}"
echo -e "  ${CYAN}/memory${RESET}          ${DIM}查看跨 session Auto Memory${RESET}"
echo ""
echo -e "  ${DIM}完整 skill 清單：ls .claude/skills/${RESET}"
echo -e "  ${DIM}完整文件索引：docs/INDEX.md${RESET}"
echo ""
