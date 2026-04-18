# Best Practices 深度研究報告

> 日期：2026-04-18
> 分支：`claude/research-claude-best-practices-2H77l`
> 來源：htlin222/dotfiles · shanraisshan/claude-code-best-practice · 官方 docs · claude.com/blog
> tags: [best-practices, research, gap-analysis]

---

## TL;DR

| 交付物 | 路徑 | 說明 |
|--------|------|------|
| `research-best-practices` Skill | `.claude/skills/research-best-practices/` | 可重複使用的研究方法論，7 步驟三層模型 |
| `token-efficiency` Rule | `.claude/rules/token-efficiency.md` | 5 層 context 壓縮策略 + compact hint 模板 |
| `cli-enhancers` Rule | `.claude/rules/cli-enhancers.md` | 10 個 CLI 增強工具目錄 |

---

## 一、研究來源摘要

### 1.1 htlin222/dotfiles（claude.symlink）

SuperClaude framework 設計，特色：
- **Wave 指令系統**：複雜度 ≥0.7 + 檔案 >20 + 操作類型 >2 自動觸發高階指令
- **5 層 token 壓縮**（MODES.md）：Minimal→Efficient→Compressed→Critical→Emergency
- **CLI enhancers 目錄**（CORE.md）：ast-grep / shellcheck / sd / scc / yq / hyperfine / delta 等
- **56 個 skills + 多個 personas**：細分領域（Analyzer / Architect / Security / QA / Mentor）
- **MCP 伺服器整合**：Context7（文檔）/ Sequential（分析）/ Magic（UI）/ Playwright（E2E）
- **Auto-trigger 閾值**：dirs>7 → delegate; files>50 → delegate; complexity>0.8 → wave-mode

**採用決策**：token-efficiency 5 層模型 + CLI enhancers 目錄 ✅；Wave/Personas/MCP 不採用（與 Advisor 架構衝突）❌

### 1.2 shanraisshan/claude-code-best-practice（tips/）

關鍵 best practices：
- **Auto Mode**（Shift+Tab）：模型決策哪些命令安全，比 `--dangerously-skip-permissions` 安全
- **Session 5 層選擇**：Continue / Rewind / Clear / Compact / Subagent + Context rot ~300-400k 主動 compact
- **PostToolUse auto-format**：避免 CI format 失敗
- **PermissionRequest hook**：路由到 Opus 審核 + 自動批准
- **Skill on-demand hooks**：/careful、/freeze 旗標
- **Git Worktree 並行開發**：`claude -w` 啟動多 session
- **驗證技能**：Backend 執行伺服器、Frontend 用 Chrome 擴展截圖
- **Compact hint 模板**：`/compact focus on X, drop Y`（比 autocompact 更可控）

**採用決策**：Compact hint 模板 → 納入 token-efficiency.md ✅；PostToolUse/PermissionRequest hook → Defer（需確認專案 formatter）⏳；Worktree/batch → 超出範疇 ❌

### 1.3 Claude Code 官方文件

最新確認的功能狀態：
- **Hooks**：7 大事件（SessionStart / PreToolUse / PostToolUse / UserPromptSubmit / SubagentStart / SubagentStop / PreCompact / PostCompact / Stop）
- **Auto Memory**（2026 Q1 GA）：`~/.claude/projects/<p>/memory/` 自動累積
- **Routines**（2026-04-14 Research Preview）：排程 / API / GitHub webhook 三種觸發
- **Adaptive Thinking**（Opus 4.7）：模型自決定思考深度，取代固定 budget
- **Effort `xhigh`**：多數 agentic 任務的最佳平衡點

**結論**：本 workspace 已完整實作；rules 文件與官方 GA 狀態一致 ✅

### 1.4 claude.com/blog（近期文章）

- **Parallel Agents**（Desktop Redesign）：Orchestrator + 多個並行 agent + Side Chat 單向流
- **官方心智模型確認**：「只需結論 → 委派 subagent」與 Advisor 模式高度吻合
- **Context rot 警示**：官方明確指出過長 context 會降低模型注意力品質

---

## 二、Gap Analysis Matrix

| 缺口 | 來源 | 優先級 | 本次採用 | 理由 |
|------|------|--------|----------|------|
| Token 壓縮 5 層策略 | htlin222 MODES.md | 高 | ✅ | 補充既有 70% 提醒的細粒度行動指引 |
| CLI enhancers 目錄 | htlin222 CORE.md | 高 | ✅ | 具體、可查、低維護成本 |
| Meta research Skill | 任務需求 | 高 | ✅ | 主交付物，使未來審計可重複執行 |
| Compact hint 模板 | shanraisshan | 中 | ✅ | 納入 token-efficiency.md |
| Wave 指令系統 | htlin222 | 中 | ❌ | 與 Advisor 架構哲學衝突 |
| Personas 系統 | htlin222 | 低 | ❌ | 與現有 agent 分層重複 |
| PostToolUse auto-format | shanraisshan | 中 | ⏳ | 需確認 formatter 環境 |
| PermissionRequest hook | shanraisshan | 低 | ⏳ | sandbox 場景不同，稍後評估 |
| MCP 伺服器整合 | htlin222 | 低 | ❌ | 環境相依，使用者未要求 |
| Quality Gates 8 段 | htlin222 | 低 | ❌ | `/deep-review` 已覆蓋同等功能 |
| /batch + Worktree 自動化 | shanraisshan | 低 | ❌ | 超出此任務 scope |

---

## 三、Karpathy 心法呼應

| 原則 | 本次實踐 |
|------|---------|
| **量化一切** | Gap matrix 3 欄 + 優先級標記 |
| **Eliminate waste** | 跳過 6 個低 ROI 項目，避免 workspace 膨脹 |
| **Profile before optimize** | 先 fan-out 研究再 advisor 確認，不提前實作 |
| **Small composable units** | 3 個交付物獨立 lazy-load，不污染 auto-load |
| **Iterate fast** | 4 個平行 researcher + advisor 確認點，避免單點阻塞 |

---

## 四、後續追蹤

- [ ] **PostToolUse auto-format hook**：確認專案 formatter（prettier/black/gofmt）後實作
- [ ] **PermissionRequest hook**：評估是否適合本 workspace 的 sandbox 配置
- [ ] **季度審計**：下次用 `research-best-practices` Skill 自動執行（目標：2026 Q3）
- [ ] **CLAUDE.md lazy-load 表更新**：補入 `token-efficiency.md` 和 `cli-enhancers.md` 的觸發條件
