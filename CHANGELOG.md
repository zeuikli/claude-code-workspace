# CHANGELOG

所有重要變更皆記錄於此文件。

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
