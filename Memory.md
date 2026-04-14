# Memory.md - 對話記憶

> 此文件用於記錄每次對話的重點摘要，以便在新對話中快速恢復上下文。

---

## Session 9 — 2026-04-14（官方 Auto Memory 遷移 + P0 全面優化）

### 完成事項
- **官方 Auto Memory 遷移**（`autoMemoryEnabled: true`）：移除 memory-pull / memory-update / memory-sync hooks，改用 `~/.claude/projects/<project>/memory/` 官方管理
- **CLAUDE.md P0 優化**：移除 @README / @Memory / @CHANGELOG 大型自動載入（省 ~6.7k tokens）；改用 @rules/*.md 模組化架構
- **settings.json 升級**：9 種 Hook 事件（+5 新增），autoMemoryEnabled:true，移除舊 memory hooks
- **session-init.sh v4**：移除 Memory.md 引用，保留 5MB threshold 智能 clone
- **hooks 全面更新**：pre-compact / post-compact / session-stop / rules/*.md 同步反映 Auto Memory
- **README.md 精簡**：快速開始指令更新（移除 Memory.md），新增 Auto Memory 說明

### 關鍵決策
- 官方 Auto Memory 取代自製 git push 鏈：官方方案由 Claude 智能決定何時記憶，更符合設計原則
- 快速開始指令僅引用 CLAUDE.md（不再需要 Memory.md 引用）
- Memory.md 保留作歷史存檔，不再在主流程中扮演角色

### 效益
- Auto-load token：~10.6k → ~3.9k tokens（−63%）
- Hook 事件：4 → 9 種
- 移除 3 個 memory hooks（memory-pull / memory-update / memory-sync on stop）

---

## Session 6 — 2026-04-14（Karpathy 風格全面優化）

### 完成事項（P0-P2 全數實作 / 10 項）
- **載入速度量化**：cold clone 0.37s / warm pull 0.27s / SessionStart hook 430ms（baseline）→ 414ms（optimized）
- **P0-1 拆分 CLAUDE.md**：84 行 → 39 行（−54%），抽出 6 個 `.claude/rules/*.md` 模組
- **P0-2 docs lazy-load**：5 個 docs（~10k tokens）改為 on-demand，新增 `docs/INDEX.md` 索引
- **P0-3 SessionStart hook 升級**：改用 `git fetch --filter=blob:none --no-tags + reset --hard FETCH_HEAD` + 毫秒級 elapsed log
- **P1-4 InstructionsLoaded Hook**：紀錄 CLAUDE.md 載入時機（實驗性）
- **P1-5 PreCompact / PostCompact / Stop Hooks**：完整覆蓋壓縮與結束事件
- **P1-6 memory-pull JSON 升級**：透過 `additionalContext` 主動注入 Memory 摘要
- **P2-7 GitHub Actions CI**：3 jobs（shellcheck / json-validate / hooks-dryrun）
- **P2-8 healthcheck.sh**：33 項檢查全綠（33 PASS / 0 FAIL）
- **P2-9 Memory 30s throttle**：lockfile 防 race condition
- **P2-10 一致性修正**：CLAUDE.md +GitHub link、README +新結構、prompts 1/2/3 統一格式
- **完整效益報告**：`docs/karpathy-optimization-report.md`

### 關鍵決策
- Sub Agent 沙箱可能拒絕 Write/Bash → Lead Agent 需設計 fallback 由主迴圈接手
- CLAUDE.md 採「主檔精簡 + rules 模組化 + docs lazy-load」三層架構
- Hook 事件從 3 種 → 7 種，補齊官方推薦 InstructionsLoaded / PreCompact / PostCompact / Stop
- Memory.md 寫入加 30 秒 throttle，避免 PostToolUse 高頻觸發

### 已修改檔案（共 16 檔，11 新增 + 5 修改）
- 新增：`.github/workflows/ci.yml`、`scripts/healthcheck.sh`、`docs/INDEX.md`、`docs/karpathy-optimization-report.md`、`.claude/rules/*.md` (6)、`.claude/hooks/instructions-loaded.sh`、`pre-compact.sh`、`post-compact.sh`、`session-stop.sh`
- 修改：`CLAUDE.md`、`README.md`、`prompts.md`、`.claude/settings.json`、`.claude/hooks/session-init.sh`、`memory-pull.sh`、`memory-update-hook.sh`、`CHANGELOG.md`、`Memory.md`

### 效益指標
- 主 auto-load token: ~8,014 → ~6,924（**−14%，省 ~1.1k tokens / session**）
- docs/ 隔離 ~10.4k tokens（不再誤入主 context）
- SessionStart hook: 430ms → 414ms（−4%）
- Healthcheck: 全新建立（33 PASS / 0 FAIL）

### 下一步待辦（Follow-up Backlog）
- [ ] **高**: 小 repo 不用 `--filter=blob:none`（cold clone 反而從 370ms 變 690ms）
- [ ] **高**: 實機驗證 InstructionsLoaded / PreCompact / PostCompact 是否真的觸發
- [ ] **高**: CI 第一次跑驗證 + 修正 shellcheck warnings
- [ ] **中**: Path-scoped rules（rules/*.md 加 `paths:` frontmatter）
- [ ] **中**: Skills 2.0 注入研究
- [ ] **中**: Memory.md 大小監控（>200 行警告）
- [ ] **低**: 評估遷移到官方 Auto Memory（取代自製 git push 鏈）
- [ ] **低**: Hook 鏈視覺化文件（mermaid 圖）
- [ ] **低**: Sub Agent 沙箱權限指南

---

## Session 5 — 2026-04-14

### 完成事項
- 執行 main branch 載入速度與內容完整性測試（git pull: 0.358s）
- 分析 workspace 狀態，發現並修復 3 個問題：
  1. Memory.md 嚴重過時（補全 Session 2-4 記錄）
  2. `session-init.sh` 本機環境 `git reset --hard` 改為安全的 `git merge --ff-only`
  3. `prompts.md` 標準開場格式統一為支援環境偵測的新版指令
- 新增 StopHook 自動儲存 Memory.md 機制

### 關鍵決策
- session-init.sh 本機使用 `git merge --ff-only` 取代 `git reset --hard`，防止覆蓋本地未提交修改
- 新增 `Stop` 事件 Hook 觸發 memory-sync，確保 session 結束時自動備份
- prompts.md 快速開場統一採用環境偵測版（同 README），提升跨環境相容性

### 已修改檔案
- `Memory.md` — 補全歷史 session 記錄
- `.claude/hooks/session-init.sh` — 修正本機 reset --hard 危險操作
- `prompts.md` — 統一標準開場 Prompt 格式
- `.claude/settings.json` — 新增 StopHook

### 下一步待辦
- 考慮加入 GitHub Actions CI，自動驗證 hooks 腳本語法
- 考慮加入 workspace 健康檢查指令（快速驗證所有組件正常）

---

## Session 4 — 2026-04-14

### 完成事項
- 調查 Stream idle timeout 根本原因（企業代理 / 長時間 Bash 操作）
- 調整 `CLAUDE_STREAM_IDLE_TIMEOUT_MS` 從 60s 至 120s（平衡相容性）
- 新增 `docs/stream-timeout-investigation.md` — 完整根因調查與解決方案
- 新增 `docs/timeout-settings-impact-analysis.md` — 設定影響分析報告
- 同步 `~/.claude/settings.json` 與 `.claude/settings.json` 的 timeout 環境變數

### 關鍵決策
- `CLAUDE_ENABLE_STREAM_WATCHDOG=1` 啟用串流監視狗
- `CLAUDE_STREAM_IDLE_TIMEOUT_MS=120000`（2分鐘，兼顧代理相容性）
- `API_TIMEOUT_MS=900000`（15分鐘）、`BASH_DEFAULT_TIMEOUT_MS=300000`（5分鐘）
- `BASH_MAX_TIMEOUT_MS=1800000`（30分鐘）

### 技術備註
- 分支 merge 至 main，commit: `karpathy-optimization-merged`

---

## Session 3 — 2026-04-13

### 完成事項
- 分析 22 篇 Claude Blog 文章，提取可操作洞察（`docs/blog-analysis-report.md`）
- 新增 6 個 Sub Agent 定義檔（`.claude/agents/`）
- 新增 4 個 Skills（deep-review、frontend-design、blog-analyzer、agent-team）
- 新增 `pre-commit-review.sh` Hook（git commit 前提醒 deep-review）
- 建立 `docs/workspace-performance-report.md`（成本 -72.4%、平行加速 2.6-7.3×）
- 新增 `cost-tracker` Skill

### 關鍵決策
- Sub Agent 三層架構確立：`Haiku`（搜尋）→ `Sonnet`（實作）→ `Opus`（審查）
- deep-review 採三維度平行審查（安全 + 效能 + 風格）
- frontend-design Skill 防止 AI slop 風格

### 已修改檔案
- `.claude/agents/` — 新增 6 個 agent 定義
- `.claude/skills/` — 新增 deep-review、frontend-design、blog-analyzer、agent-team、cost-tracker
- `.claude/hooks/pre-commit-review.sh` — 新增
- `.claude/settings.json` — 加入 pre-commit hook
- `CLAUDE.md` — 加入 Sub Agent 委派規則
- `README.md` — 更新檔案結構
- `docs/` — 新增 3 份報告

---

## Session 2 — 2026-04-13

### 完成事項
- 建立 `docs/advisor-strategy.md`（Advisor 模式完整說明）
- 建立 `prompts.md`（6 種情境萬用 Prompt）
- 新增 3 個核心 Sub Agent（researcher、implementer、reviewer）
- 加入 `PreToolUse Hook`（memory-pull.sh）
- 優化 session-init.sh 為本機 + 雲端通用版

### 關鍵決策
- Advisor 模式：Haiku/Sonnet 執行、Opus 顧問（僅關鍵決策時諮詢）
- Memory.md 同步採三階段自動化（SessionStart → PreToolUse → PostToolUse）
- 基於 AgentOpt 論文與 Anthropic Advisor Strategy 設計

### 技術備註
- Git 分支皆 merge 至 main 並推送 GitHub

---

## Session 1 — 2026-04-12

### 完成事項
- 建立 `CLAUDE.md`，包含語言規則、Sub Agent 策略、Context Window 管理、Git 工作流程等指令
- 根據官方最佳實踐全面優化 CLAUDE.md
- 建立 `Memory.md`、`CHANGELOG.md`

### 關鍵決策
- CLAUDE.md 以繁體中文撰寫，遵循官方「精簡、可操作、強調重要規則」原則
- 使用 `IMPORTANT` 和 `YOU MUST` 標記關鍵規則以提高遵循率
- 加入 compaction 指引，確保對話壓縮時保留關鍵資訊
- 加入驗證與品質區塊，符合官方「提供驗證機制」建議

### 自動化架構（完成）
- **SessionStart Hook** (`session-init.sh`): 本機 git pull / 雲端 git clone
- **PreToolUse Hook** (`memory-pull.sh`): 讀取 Memory.md 前拉取最新版
- **PostToolUse Hook** (`memory-update-hook.sh` → `memory-sync.sh`): 自動 commit + push
- 三組 Hook 完整覆蓋 session 生命週期：啟動 → 讀取 → 寫入

### 技術備註
- Git 分支：`claude/update-claude-instructions-N0AZg`
- 所有變更皆 merge 至 main 並推送到 GitHub
