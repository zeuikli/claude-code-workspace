# CHANGELOG

所有重要變更皆記錄於此文件。

---

## 2026-04-17 (opus-4.7-rewrite v2) — 導入 blog-archive 最新洞察深化 Opus 4.7 優化

### 改寫依據（本輪新增）

基於 `blog-archive` 分支已彙整的 21 篇文章，針對 v1 升級尚未覆蓋的洞察做深化：

1. [`harnessing-claudes-intelligence`](https://claude.com/blog/harnessing-claudes-intelligence) — Prompt Caching「靜態優先」5 原則
2. [`multi-agent-coordination-patterns`](https://claude.com/blog/multi-agent-coordination-patterns) — 5 種協調模式決策表
3. [`seeing-like-an-agent`](https://claude.com/blog/seeing-like-an-agent) — 工具設計心智模型 + Progressive Disclosure
4. [`claude-code-desktop-redesign`](https://claude.com/blog/claude-code-desktop-redesign) — Side Chat 第 6 種分支選項
5. [`best-practices-for-using-claude-opus-4-7-with-claude-code`](https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code) — Auto Mode 完成通知 hook 完整範例

### 新增

- `docs/multi-agent-coordination.md` — 5 種多 agent 協調模式完整決策表（lazy-load 參考文件）

### 修改

- `.claude/rules/context-management.md` — 新增 **Prompt Caching 最大化** 段落（5 原則：Static first / Messages for updates / Don't change models / Carefully manage tools / Update breakpoints）
- `.claude/rules/subagent-strategy.md` — 新增 **工具設計心智模型** 段落（seeing like an agent + Progressive Disclosure + Subagent 作為動作空間擴充）
- `.claude/rules/session-management.md` — Branching point 由 5 選項擴展為 **6 選項**，新增 Side Chat（⌘+;/Ctrl+;）完整段落
- `.claude/rules/opus47-best-practices.md` — §3 task-upfront 段補上 **Auto Mode 完成通知 hook** 完整 JSON 範例（afplay/paplay/bell fallback）
- `prompts.md` — 修正既有 bug：`##7-##10` 重複章節整併；新增 `##11 Auto Mode` 與 `##12 Prompt Caching 最大化` 兩個萬用 prompt
- `CLAUDE.md` — 進階文件索引新增 `docs/multi-agent-coordination.md`
- `.claude/REFERENCES.md` — 設計策略表新增 Seeing Like an Agent / Desktop Redesign；Multi-Agent Coordination 對應補上 `docs/multi-agent-coordination.md`

### 設計決策

- **為何 4 項改成 append 現有檔**（顧問建議）：新增多個 rule 檔會擴大 index 與 CLAUDE.md lookup 成本；prompt-caching 是 context 概念、tool-design 是 subagent 議題，就近擴寫比另起檔更符合 Progressive Disclosure。
- **為何 multi-agent-coordination 改放 `docs/`**：5 模式是參考 / 決策表，非行為規則；應 lazy-load 而非常駐載入。
- **為何先修 prompts.md 的既有重複章節**：該 bug 已在 v1 合入分支，繼續新增內容會堆在破損結構上。

### 驗證

- `scripts/healthcheck.sh` 通過
- `markdownlint .` 無新增 lint 錯誤
- `grep -n "^@" CLAUDE.md`：所有 `@path` 引用檔案皆存在
- 每條新增段落皆逐字比對 blog-archive 原文（見 git 歷史的 commit message）

---

## 2026-04-17 (opus-4.7-rewrite v1) — 全 workspace 升級至 Opus 4.7 + Sonnet 4.6

### 改寫依據

基於 `blog-archive` 分支三篇核心文章：

1. [`best-practices-for-using-claude-opus-4-7-with-claude-code`](https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code)（2026-04-16）
2. [`using-claude-code-session-management-and-1m-context`](https://claude.com/blog/using-claude-code-session-management-and-1m-context)（2026-04-15）
3. [`introducing-routines-in-claude-code`](https://claude.com/blog/introducing-routines-in-claude-code)（2026-04-14）

### 新增

- `.claude/rules/opus47-best-practices.md` — **Opus 4.7 調校指南**：effort 等級（含新 `xhigh`）、自適應思考、subagent 保守行為、tokenizer 變化、task-upfront 範本
- `.claude/rules/session-management.md` — **Session 管理完整決策表**：continue / rewind / compact / clear / subagent 五選一；bad autocompact 的成因與預防
- `.claude/rules/routines.md` — **Claude Code Routines**（research preview）：scheduled / API / GitHub webhook 三種觸發模式與 workspace 整合建議
- `docs/opus47-migration.md` — 4.6 → 4.7 完整遷移指引，含 settings diff、prompt 習慣調整、驗證清單、FAQ

### 修改

- `CLAUDE.md` — 核心原則新增四條 Opus 4.7 相關規則（xhigh 預設、task-upfront、subagent 保守行為、`/rewind` 優先）；規則索引加入 opus47-best-practices / session-management / routines
- `.claude/settings.json` — 新增 `model: claude-opus-4-7`、`effortLevel: xhigh`、`alwaysThinkingEnabled: true`、`advisorModel: claude-opus-4-7`
- `.claude/rules/subagent-strategy.md` — 標註 Opus 4.7 subagent 行為差異（預設保守，需明確指示平行化）；Advisor 模式更新為 Sonnet 4.6 / Haiku 4.5 執行 + Opus 4.7 顧問；加入漸進式委派策略
- `.claude/rules/context-management.md` — 加入 `/usage` 指令、context rot 認知、主動 compact 策略；參照 session-management.md
- `README.md` — 全面重寫，凸顯 Opus 4.7 亮點；更新分支說明、檔案結構、核心配置

### 設計決策

- **為何預設 `xhigh`**：官方建議多數 agentic 編碼任務的最佳權衡；避免 `max` 長 session 爆 token。
- **為何保留 Advisor 模式**：Opus 4.7 雖強但成本仍高，Sonnet 4.6 / Haiku 4.5 適合主迴圈，Opus 4.7 留給架構決策與長 session recovery。
- **為何獨立 session-management.md**：1M context + `/rewind` + `/usage` 是本次升級最大工作流變化，值得獨立文件。
- **為何加 routines.md**：雖是 research preview，但對自動化 backlog / deploy / CI 有明確 ROI，且文件輕量（<100 行）。

### 效益預估

- **同任務 token 節省**：一次給完整規格 → 減少 user turn → Opus 4.7 在後期 turn 的推理 overhead 降低（預估 -15~25%）
- **錯誤方向恢復成本**：`/rewind` vs 口頭修正（預估 -40% context 污染）
- **平行化效率**：明確指示 subagent fan-out → 3+ 獨立子任務可真正平行執行

---

## 2026-04-14 (auto-memory-migration) — Session 9 官方 Auto Memory 遷移 + P0 全面優化

### 重大架構變更
- **切換至官方 Auto Memory**：移除自製 Memory.md git push 鏈，改用 Claude Code 內建 `autoMemoryEnabled: true`
  - 記憶存於 `~/.claude/projects/<project>/memory/`，Claude 自動累積跨 session 知識
  - 使用 `/memory` 指令查看或編輯 Auto Memory 內容
  - 無需 PreToolUse:read / PostToolUse:write / Stop memory-sync hooks

### P0 優化（Context Token 大幅削減）
- `CLAUDE.md`：移除 `@README.md` / `@Memory.md` / `@CHANGELOG.md` 三大自動載入（省 ~6k tokens）；改用 `@.claude/rules/*.md` 模組化（僅載入 rules）；加入 Auto Memory 說明
- `settings.json`：加入 `autoMemoryEnabled: true`；移除 PreToolUse:read（memory-pull）/ PostToolUse:write|edit（memory-update）hooks；補齊完整 9 種 Hook 事件（+InstructionsLoaded / UserPromptSubmit / SubagentStart / SubagentStop / PreCompact / PostCompact）
- `session-init.sh`：升級至 v4，移除 Memory.md 引用；採用 5MB threshold 智能 partial clone；增加毫秒計時
- `README.md`：全面精簡，快速開始指令移除 Memory.md 引用，加入 Auto Memory 說明

### 同步更新
- `.claude/rules/context-management.md`：更新說明至 Auto Memory 架構
- `.claude/rules/auto-sync.md`：更新說明至新 9 hook 架構
- `.claude/hooks/pre-compact.sh`：提醒改為 Auto Memory + TodoWrite
- `.claude/hooks/post-compact.sh`：恢復提示改為 `/memory` 指令
- `.claude/hooks/session-stop.sh`：移除 memory-sync，改為記錄日誌

### 效益指標
- Auto-load token：~10.6k → ~3.9k tokens（**−63%**）
- Memory 同步延遲：移除（官方 Auto Memory 即時處理）
- Hook 事件：4 → **9 種**（SessionStart / InstructionsLoaded / UserPromptSubmit / SubagentStart / SubagentStop / PreToolUse:bash / PreCompact / PostCompact / Stop）

---

## 2026-04-14 (workspace-integrity-optimization)

### 修復
- `.claude/hooks/session-init.sh` — 本機環境改用 `git merge --ff-only` 取代 `git reset --hard`，防止自動同步覆蓋本地未提交的修改

### 優化
- `Memory.md` — 補全 Session 2-4 完整歷史記錄（Advisor 模式、Agents、Skills、Hooks、timeout 設定）
- `prompts.md` — 標準開場（Prompt 1）與完整載入（Prompt 5）統一採用支援環境偵測的新版指令（同 README 快速開始）

### 新增
- `.claude/hooks/session-stop.sh` — Stop Hook，session 結束時自動觸發 Memory.md 同步備份
- `.claude/settings.json` — 加入 `Stop` 事件 Hook，完整覆蓋 session 生命週期（啟動 → 讀取 → 寫入 → 結束）

---

## 2026-04-14 (karpathy-optimization-merged)

### 修復
- `~/.claude/settings.json` — 新增 stream timeout 環境變數設定，並調整 `CLAUDE_STREAM_IDLE_TIMEOUT_MS` 從 60s 至 120s（平衡企業代理相容性與長時間 Bash 操作穩定性）
- `.claude/settings.json` — 同步專案層級 timeout 設定（`CLAUDE_ENABLE_STREAM_WATCHDOG=1`、`CLAUDE_STREAM_IDLE_TIMEOUT_MS=120000`、`API_TIMEOUT_MS=900000`、`BASH_DEFAULT_TIMEOUT_MS=300000`、`BASH_MAX_TIMEOUT_MS=1800000`）

### 新增
- `docs/stream-timeout-investigation.md` — Stream idle timeout 完整調查報告，含根本原因分析、環境變數說明、企業網路解法、快速診斷 Checklist
- `docs/timeout-settings-impact-analysis.md` — Timeout 設定影響分析報告，含各 hooks/agents/skills 相容性矩陣、設定優先級衝突分析、`BASH_MAX` vs `STREAM_IDLE` 隱性張力說明

---

## 2026-04-13 (5)

### 新增
- `.claude/skills/cost-tracker/SKILL.md` — Token 使用量與花費追蹤 Skill，含定價表、計算公式、Agent SDK 整合範例
- `docs/workspace-performance-report.md` — 完整效能報告：成本對比（-72.4%）、平行加速（2.6-7.3×）、自動化效益、Agent SDK 整合指南

---

## 2026-04-13 (4)

### 新增（來自 blog-archive 分析）
- `.claude/agents/security-reviewer.md` — Sonnet 安全審查 Agent（注入、認證、敏感資料）
- `.claude/agents/architecture-explorer.md` — Haiku 架構探索 Agent（模組、路由映射）
- `.claude/agents/test-writer.md` — Sonnet 測試撰寫 Agent（邊界條件、錯誤處理）
- `.claude/skills/deep-review/SKILL.md` — 三維度平行程式碼審查（安全+效能+風格）
- `.claude/skills/frontend-design/SKILL.md` — 前端設計指引，避免 AI slop
- `.claude/skills/blog-analyzer/SKILL.md` — Blog 文章分析器，提取可操作洞察
- `.claude/skills/agent-team/SKILL.md` — Agent Team 多 Worker 平行協作模式
- `.claude/hooks/pre-commit-review.sh` — Pre-commit Hook，偵測 git commit 提醒使用 deep-review
- `docs/blog-analysis-report.md` — 22 篇 Claude Blog 文章完整分析報告

### 更新
- `CLAUDE.md` — 加入 Sub Agent 委派規則（6 個 Agent 各司其職的場景對照）
- `.claude/settings.json` — 加入 Pre-commit review Hook
- `README.md` — 更新檔案結構，反映所有新增的 Agents、Skills、Hooks

---

## 2026-04-13 (3)

### 新增
- `.claude/agents/researcher.md` — Haiku 搜尋探索型 Sub Agent
- `.claude/agents/implementer.md` — Sonnet 實作驗證型 Sub Agent
- `.claude/agents/reviewer.md` — Opus 架構審查型 Sub Agent（顧問角色）

### 優化
- 基於四篇官方文件全面重構：
  - [Multi-Agent Coordination Patterns](https://claude.com/blog/multi-agent-coordination-patterns)
  - [Subagents in Claude Code](https://claude.com/blog/subagents-in-claude-code)
  - [Harnessing Claude's Intelligence](https://claude.com/blog/harnessing-claudes-intelligence)
  - [Claude Managed Agents](https://claude.com/blog/claude-managed-agents)
- `CLAUDE.md` — 將策略從文字描述落實為 `.claude/agents/` 定義
- `README.md` — 更新檔案結構，反映新增的 agents 目錄

---

## 2026-04-13 (2)

### 新增
- `prompts.md` — 萬用 Prompt 集，包含 6 種情境：標準開場、極簡驗證、接續工作、新專案初始化、完整載入、結束 Session

### 更新
- `CLAUDE.md` — 參考文件加入 prompts.md 與 advisor-strategy.md 引用
- `README.md` — 檔案結構加入 prompts.md

---

## 2026-04-13

### 新增
- `docs/advisor-strategy.md` — Advisor 模式完整說明文件，含架構圖、API 範例、效能基準、選型建議
  - 基於 [AgentOpt 論文](https://arxiv.org/html/2604.06296v1)、[Anthropic Advisor Strategy](https://claude.com/blog/the-advisor-strategy) 整理

### 更新
- `CLAUDE.md` — 加入「Advisor 模式（顧問策略）」區塊：Haiku/Sonnet 主迴圈 + Opus 顧問、Sub Agent 分層模型選用、諮詢時機指引
- `README.md` — 更新專案概述、檔案結構、核心配置表

---

## 2026-04-12 (4)

### 新增
- `.claude/hooks/memory-pull.sh` — PreToolUse Hook，讀取 Memory.md 前自動從 GitHub 拉取最新版本

### 更新
- `.claude/settings.json` — 加入 PreToolUse Hook（Read），三組 Hook 完整覆蓋 Session 生命週期
- `CLAUDE.md` — 補充 PreToolUse 說明，標記 Memory.md 同步為全自動
- `README.md` — 更新流程圖與檔案結構，加入 PreToolUse 階段

---

## 2026-04-12 (3)

### 新增
- `.claude/hooks/memory-sync.sh` — Memory.md 自動同步腳本（commit + push 回 GitHub，含重試機制）
- `.claude/hooks/memory-update-hook.sh` — PostToolUse Hook，偵測 Memory.md 被寫入後自動觸發同步

### 重構
- `.claude/hooks/session-init.sh` — 增強為本機 + 雲端通用版，本機自動 git pull、雲端自動 git clone，並確保 `~/.claude/CLAUDE.md` 正確建立
- `.claude/settings.json` — 整合 SessionStart + PostToolUse 兩組 Hook

### 更新
- `CLAUDE.md` — 加入自動化同步機制說明
- `README.md` — 新增自動化同步流程圖、其他專案啟用方式、更新檔案結構
- `~/.claude/CLAUDE.md` — 確認全域引用正確

---

## 2026-04-12 (2)

### 新增
- `.claude/hooks/session-init.sh` — SessionStart Hook，雲端 session 啟動時自動 clone repo 並建立全域 CLAUDE.md
- `.claude/settings.json` — Hook 設定檔，註冊 SessionStart 事件

### 更新
- `README.md` — 新增本機端與雲端 / 手機的完整設定指引，更新檔案結構圖

---

## 2026-04-12

### 新增
- `CLAUDE.md` — 專案指令檔，包含語言規則、Sub Agent 策略、Context Window 管理、Git 工作流程、驗證與品質指引
- `Memory.md` — 對話記憶檔，用於跨對話上下文保存
- `CHANGELOG.md` — 變更紀錄檔

### 優化
- 根據 Claude Code 官方最佳實踐全面重構 CLAUDE.md：
  - 精簡內容，移除 Claude 已知的通用慣例
  - 使用 `IMPORTANT` / `YOU MUST` 強調關鍵規則
  - 新增 compaction 指引，確保壓縮時保留關鍵資訊
  - 新增驗證與品質區塊
  - 新增 `@` 引用語法連結相關文件
  - Git 工作流程細化，加入重試機制與安全提醒
