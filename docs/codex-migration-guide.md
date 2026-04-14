# Claude Code Workspace → OpenAI Codex 遷移分析指南

> 分析基準：官方 OpenAI Codex 文件（2025）  
> 原始 workspace：`zeuikli/claude-code-workspace`  
> 目的：評估哪些設計可直接移植、哪些需調整、哪些為 Claude 專屬

---

## 一、總覽：適用性評估

| 類別 | Claude Code | Codex 等效方案 | 適用性 |
|------|------------|--------------|--------|
| 專案指令檔 | `CLAUDE.md` | `AGENTS.md` | ✅ 直接移植 |
| 模組化規則 | `.claude/rules/*.md` | `AGENTS.md` 各段落 / 子目錄 `AGENTS.md` | ✅ 需整合 |
| 設定檔 | `.claude/settings.json` (JSON) | `.codex/config.toml` (TOML) | ⚠️ 格式不同，需改寫 |
| 跨 session 記憶 | `autoMemoryEnabled: true` | `~/.codex/memory/*.md` | ✅ 概念相同，路徑不同 |
| Sub Agents | `.claude/agents/*.md` | Codex Subagents (`config.toml [agents]`) | ✅ 需重新定義 |
| Skills / 斜杠命令 | `.claude/skills/*/SKILL.md` | Codex Agent Skills | ⚠️ 部分適用 |
| Hooks — SessionStart | `session-init.sh` | Codex SessionStart Hook | ✅ 直接移植 |
| Hooks — UserPromptSubmit | `user-prompt-submit.sh` | Codex UserPromptSubmit Hook | ✅ 直接移植 |
| Hooks — Stop | `session-stop.sh` | Codex Stop Hook | ✅ 直接移植 |
| Hooks — PreToolUse:bash | `pre-commit-review.sh` | ⚠️ 需確認支援狀況 | ⚠️ 不確定 |
| Hooks — PreCompact / PostCompact | `pre-compact.sh` / `post-compact.sh` | ❌ Claude 專屬（壓縮機制） | ❌ 不適用 |
| Hooks — InstructionsLoaded | `instructions-loaded.sh` | ❌ Claude 專屬 | ❌ 不適用 |
| Hooks — SubagentStart / SubagentStop | `subagent-start/stop.sh` | ⚠️ 需確認支援狀況 | ⚠️ 不確定 |
| Git 工作流規則 | `.claude/rules/git-workflow.md` | `AGENTS.md` 內嵌規則 | ✅ 直接移植 |
| 健康檢查腳本 | `scripts/healthcheck.sh` | ✅ Shell 腳本通用 | ✅ 直接使用 |
| GitHub Actions CI | `.github/workflows/ci.yml` | ✅ 與工具無關 | ✅ 直接使用 |

---

## 二、各功能遷移細節

### 2.1 CLAUDE.md → AGENTS.md（✅ 直接移植）

Codex 使用 `AGENTS.md`，功能完全對應。可多層級覆蓋：
- `~/.codex/AGENTS.md` — 全域使用者層級
- `<project>/AGENTS.md` — 專案層級
- `<project>/<subdir>/AGENTS.md` — 子目錄層級（覆蓋上層）
- `AGENTS.override.md` — 最高優先級（本地開發覆蓋，建議加入 `.gitignore`）

**建議動作**：將 `CLAUDE.md` 直接複製並重命名為 `AGENTS.md`，調整措辭（移除 Claude 專屬術語）。

```bash
# 執行步驟
cp CLAUDE.md AGENTS.md
# 將 @.claude/rules/ 引用改為內嵌內容或子目錄 AGENTS.md
```

---

### 2.2 `.claude/rules/*.md` → `AGENTS.md` 各段落（✅ 需整合）

Claude Code 的模組化規則（`@.claude/rules/language.md` 等）可改為：

**方案 A（推薦）**：合併為單一 `AGENTS.md`
```markdown
# AGENTS.md

## 語言規則
使用者用中文時，回覆台灣繁體中文。英文對話回覆英文。

## Sub Agent 策略
能委派 Sub Agent 的任務優先委派...（原內容）

## Git 工作流程
每次改動完成後：git add → commit → push...（原內容）
```

**方案 B**：子目錄 `AGENTS.md`（適合大型 monorepo）
```
project/
├── AGENTS.md           # 根層全域規則
├── src/AGENTS.md       # 前端規則
└── backend/AGENTS.md   # 後端規則
```

---

### 2.3 `.claude/settings.json` → `.codex/config.toml`（⚠️ 格式不同）

**原 Claude Code settings.json 對應的 Codex config.toml：**

```toml
# .codex/config.toml

[model]
# Codex 使用 OpenAI 模型
default = "codex-1"            # 主力模型（等同 Sonnet）
# subagent = "o4-mini"         # Sub Agent 使用輕量模型（等同 Haiku）

[approval]
# 命令執行前是否需要人工確認
mode = "auto"                  # "auto" = 自動執行，"manual" = 每次確認

[features]
memory = true                  # 等同 autoMemoryEnabled: true
web_search = true              # 啟用網頁搜尋

[agents]
# Sub Agent 定義（等同 .claude/agents/*.md）
# 詳見 2.4 節

[mcp_servers]
# Model Context Protocol 伺服器（Claude Code 無對應）
```

**注意**：`env` 區塊的 timeout 設定（`CLAUDE_STREAM_IDLE_TIMEOUT_MS` 等）為 Claude 專屬環境變數，Codex 不適用。

---

### 2.4 `.claude/agents/*.md` → Codex Subagents（✅ 需重新定義）

Codex Sub Agents 透過 `config.toml` 的 `[agents]` 區塊定義，並在 AGENTS.md 中說明委派策略。

**原 Claude Code agents 對應關係：**

| Claude Code Agent | Codex 對應模型 | 角色 |
|------------------|--------------|------|
| `researcher.md` (Haiku) | `o4-mini` | 搜尋 / 探索 |
| `architecture-explorer.md` (Haiku) | `o4-mini` | 架構分析 |
| `implementer.md` (Sonnet) | `codex-1` | 實作 |
| `test-writer.md` (Sonnet) | `codex-1` | 測試 |
| `security-reviewer.md` (Sonnet) | `codex-1` | 安全審查 |
| `reviewer.md` (Opus) | `o3` | 架構決策（顧問） |
| `code-reviewer.md` (Opus) | `o3` | 程式碼審查 |
| `doc-writer.md` (Haiku) | `o4-mini` | 文件生成 |
| `memory-compactor.md` (Haiku) | `o4-mini` | 記憶壓縮 |

**Codex 重要特性**：每個 subagent 自動獲得獨立 Git worktree，天然避免並行衝突。

**AGENTS.md 中的委派規則（可直接移植內容）：**
```markdown
## Sub Agent 委派策略

- 研究型任務（>10 檔案）：委派輕量模型 subagent（等同 researcher）
- 平行獨立工作（3+ 子任務）：同時啟動多個 subagents
- 程式碼實作：委派 codex-1 subagent
- 架構決策：委派 o3 subagent（顧問模式，僅關鍵時刻）
- 安全審查：委派 codex-1 subagent（非必要不用 o3）
```

---

### 2.5 Hooks 系統（部分適用）

**✅ 直接移植的 Hooks：**

| Hook 事件 | 原腳本 | Codex 支援 | 說明 |
|-----------|--------|-----------|------|
| `SessionStart` | `session-init.sh` | ✅ | 可移植（移除 Claude 專屬邏輯） |
| `UserPromptSubmit` | `user-prompt-submit.sh` | ✅ | Sub Agent 提醒注入 |
| `Stop` | `session-stop.sh` | ✅ | Session 結束記錄 |

**Codex hooks 設定格式（`~/.codex/hooks.json` 或 `.codex/hooks.json`）：**

```json
{
  "SessionStart": [
    {
      "command": "bash .codex/hooks/session-init.sh"
    }
  ],
  "UserPromptSubmit": [
    {
      "command": "bash .codex/hooks/user-prompt-submit.sh"
    }
  ],
  "Stop": [
    {
      "command": "bash .codex/hooks/session-stop.sh"
    }
  ]
}
```

**需調整的 `session-init.sh`（移除 Claude 專屬部分）：**
```bash
#!/bin/bash
# Codex 版 session-init.sh（移除 ~/.claude/ 引用）
REPO="https://github.com/zeuikli/claude-code-workspace.git"
DIR="/tmp/codex-workspace"

if [ -d "$DIR/.git" ]; then
  git -C "$DIR" pull -q origin main
else
  git clone --depth 1 -q "$REPO" "$DIR"
fi
# 複製 AGENTS.md 到工作目錄（若需要）
echo "[session-init] Workspace ready at $DIR"
```

---

**❌ 不適用的 Hooks（Claude 專屬）：**

| Hook 事件 | 原因 | 建議替代 |
|-----------|------|---------|
| `PreCompact` / `PostCompact` | Context compaction 為 Claude Code 專屬機制 | 無（Codex 自動管理） |
| `InstructionsLoaded` | Claude Code 指令載入事件 | 無對應 |
| `PreToolUse:read` (memory-pull) | Codex memory 自動管理，不需手動 pull | 移除 |
| `PostToolUse:write\|edit` (memory-update) | Codex memory 自動管理，不需手動 push | 移除 |

**⚠️ 待確認的 Hooks：**

| Hook 事件 | 不確定原因 |
|-----------|----------|
| `SubagentStart` / `SubagentStop` | 官方文件未明確說明此事件名稱 |
| `PreToolUse:bash` (pre-commit-review) | Codex PreToolUse 支援狀況不確定 |

---

### 2.6 Auto Memory（✅ 概念相同，路徑不同）

| 項目 | Claude Code | Codex |
|------|------------|-------|
| 啟用方式 | `"autoMemoryEnabled": true` in settings.json | `[features] memory = true` in config.toml |
| 儲存位置 | `~/.claude/projects/<project>/memory/MEMORY.md` | `~/.codex/memory/` |
| 管理方式 | Claude 自動決定何時記憶 | diff-based forgetting（自動移除過時事實） |
| 手動查看 | `/memory` 指令 | （待確認 Codex 指令） |

**注意**：原 `Memory.md` git push 鏈（memory-pull.sh / memory-update-hook.sh）完全不需要移植，兩個平台都已改用官方自動記憶。

---

### 2.7 `.claude/skills/*/SKILL.md` → Codex Agent Skills（⚠️ 部分適用）

Codex Agent Skills 支援類似 Slash 命令的功能，但官方文件較簡略。

**可移植的核心內容（Prompt 邏輯）：**
- `deep-review` → 在 AGENTS.md 中定義三維度審查流程
- `cost-tracker` → 在 AGENTS.md 中定義 token 追蹤指令
- `blog-analyzer` → 在 AGENTS.md 中定義分析框架

**建議方式**：將 Skills 的核心 Prompt 移入 `AGENTS.md` 的「可觸發任務」段落，待 Codex Skills 文件完整後再遷移。

---

### 2.8 GitHub Actions CI（✅ 直接使用）

`.github/workflows/ci.yml`（shellcheck / json-validate / markdown-lint）與工具無關，可直接在 Codex 專案中使用。

**唯一需調整**：將 json-validate job 的目標改為 `.codex/config.toml`（TOML 驗證），或直接移除 json-validate 改用 `taplo` 驗證。

---

### 2.9 `scripts/healthcheck.sh`（✅ 直接使用，需調整路徑）

核心 Shell 腳本邏輯可用，但需替換路徑引用：

```bash
# 原 Claude Code 路徑 → Codex 等效路徑
~/.claude/settings.json → .codex/config.toml
.claude/settings.json   → .codex/config.toml
.claude/agents/         → （AGENTS.md 或 config.toml [agents]）
.claude/skills/         → （AGENTS.md 中的 Skills 段落）
.claude/hooks/          → .codex/hooks/
.claude/rules/          → （合併至 AGENTS.md）
Memory.md               → ~/.codex/memory/
```

---

## 三、遷移優先級行動計畫

### P0 — 立即可執行（高 ROI）

- [ ] **建立 `AGENTS.md`**：合併 `CLAUDE.md` + `.claude/rules/*.md` 所有規則
- [ ] **建立 `.codex/config.toml`**：對應 `.claude/settings.json`（移除 Claude 環境變數）
- [ ] **建立 `.codex/hooks/` 目錄**：移植 session-init.sh / user-prompt-submit.sh / session-stop.sh（移除 Claude 專屬邏輯）
- [ ] **建立 `.codex/hooks.json`**：只保留 SessionStart / UserPromptSubmit / Stop

### P1 — 需調整後移植

- [ ] **重寫 Sub Agent 定義**：依 Codex `config.toml [agents]` 格式，對應原有 9 個 agents
- [ ] **更新 `scripts/healthcheck.sh`**：替換路徑引用
- [ ] **更新 `ci.yml`**：json-validate job 改為 TOML 驗證

### P2 — 待 Codex 文件完整後確認

- [ ] **Skills 遷移**：確認 Codex Agent Skills 完整語法後再遷移
- [ ] **SubagentStart / Stop hooks**：確認 Codex 是否支援此事件
- [ ] **PreToolUse:bash hook**（pre-commit-review）：確認 Codex PreToolUse 支援狀況

### ❌ 不需移植

- `pre-compact.sh` / `post-compact.sh` — Claude 壓縮機制專屬
- `instructions-loaded.sh` — Claude 指令載入事件專屬
- `memory-pull.sh` / `memory-update-hook.sh` — 已被 Codex 官方 memory 取代
- Claude 環境變數（`CLAUDE_ENABLE_STREAM_WATCHDOG` / `CLAUDE_STREAM_IDLE_TIMEOUT_MS` 等）

---

## 四、核心 `AGENTS.md` 範本（可直接交給 Codex 執行）

```markdown
# AGENTS.md

> Codex 個人工作區指令檔
> Repo: https://github.com/zeuikli/claude-code-workspace

## 核心原則

- 中文對話用台灣繁體中文，英文對話用英文。
- 能用 Sub Agent 處理的請求優先委派 Sub Agent，主對話僅接收摘要。
- 採 Advisor 模式：輕量模型（o4-mini）跑搜尋/探索，主力模型（codex-1）跑實作，o3 退居幕後當架構顧問。
- Context 接近上限時提醒使用者。
- 改動完成後：git add → commit → push -u origin <branch>（失敗重試 4 次）。
- 跨對話記憶由 Codex 官方 Memory 自動管理，無需手動維護。

## Sub Agent 委派規則

- 研究型任務（>10 檔案）：委派 o4-mini subagent
- 平行獨立工作（3+ 子任務）：同時啟動多個 subagents（Codex 自動分配獨立 worktree）
- 程式碼實作：委派 codex-1 subagent
- 測試撰寫：委派 codex-1 subagent
- 安全審查：委派 codex-1 subagent
- 架構決策：僅此情境委派 o3 subagent

## Git 工作流程

每次改動完成後：
1. git add 相關檔案（避免 git add -A）
2. git commit（清晰的 commit message）
3. git push -u origin <branch>（失敗重試最多 4 次）
4. 按需更新 README.md 與 CHANGELOG.md

## 驗證與品質

- 程式碼變更後優先執行相關測試或 lint。
- 執行 bash scripts/healthcheck.sh 驗證 workspace 完整性。
```

---

## 五、官方參考資源

- [Codex CLI 官方文件](https://platform.openai.com/docs/codex)
- [AGENTS.md 自訂指令](https://platform.openai.com/docs/codex/guides/agents-md)
- [Codex Hooks](https://platform.openai.com/docs/codex/hooks)
- [Codex Subagents](https://platform.openai.com/docs/codex/subagents)
- [config.toml 設定參考](https://platform.openai.com/docs/codex/config-reference)
- [Codex GitHub Repo](https://github.com/openai/codex)

> ⚠️ **注意**：Codex 功能持續更新中，建議執行前先確認最新官方文件，特別是 Hooks 支援事件清單與 Skills 語法。
