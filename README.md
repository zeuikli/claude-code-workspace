# Claude Code Workspace

針對 [Claude Code](https://code.claude.com) 優化的個人開發工作區，內建專案指令、對話記憶管理與自動化工作流程配置。

## 快速開始

將以下 Prompt 貼進任何 Claude Code session 即可立即套用所有設定：

```
請執行 git clone --depth 1 https://github.com/zeuikli/claude-code-workspace.git /tmp/claude-code-workspace 2>/dev/null || git -C /tmp/claude-code-workspace pull -q origin main，然後讀取 /tmp/claude-code-workspace/CLAUDE.md 並遵循所有指令。
```

## 專案概述

本專案作為 Claude Code 的工作環境，透過精心設計的 `CLAUDE.md` 指令檔，實現：

- **雙語自動回覆** — 中文對話回覆台灣繁體中文，英文對話回覆英文
- **Advisor 模式（顧問策略）** — Haiku/Sonnet 跑主迴圈，Opus 退居幕後當顧問
- **Context Window 智慧管理** — 接近 70% 使用量時自動提醒，搭配 Memory.md 跨對話記憶
- **Git 自動化工作流程** — 改動完成後自動 push、merge，並按需更新文件

## 檔案結構

```
claude-code-workspace/
├── .github/
│   └── workflows/ci.yml           # CI：shellcheck + JSON schema + hooks dry-run
├── scripts/
│   └── healthcheck.sh             # 一鍵驗證 workspace 完整性（25 個檢查項）
├── .claude/
│   ├── settings.json              # Hook 設定（SessionStart + PreToolUse + PostToolUse + PreCompact + PostCompact + Stop）
│   ├── hooks/
│   │   ├── session-init.sh        # SessionStart：拉取最新指令（含 elapsed log）
│   │   ├── instructions-loaded.sh # InstructionsLoaded：紀錄 CLAUDE.md 載入時機（除錯用）
│   │   ├── memory-pull.sh         # PreToolUse：讀取前拉取 + JSON additionalContext 注入
│   │   ├── memory-sync.sh         # Memory.md commit + push（含重試）
│   │   ├── memory-update-hook.sh  # PostToolUse：含 30s throttle 防 race
│   │   ├── pre-commit-review.sh   # PreToolUse(Bash)：git commit 前提醒 deep-review
│   │   ├── pre-compact.sh         # PreCompact：壓縮前提醒更新 Memory.md
│   │   ├── post-compact.sh        # PostCompact：壓縮後提示從 Memory.md 恢復
│   │   └── session-stop.sh        # Stop：session 結束時觸發 memory-sync
│   ├── rules/                     # 拆分的細則（CLAUDE.md 按需 @ 引用，節省主 context）
│   │   ├── language.md            # 語言規則
│   │   ├── subagent-strategy.md   # Sub Agent + Advisor 模式
│   │   ├── context-management.md  # Context Window 管理
│   │   ├── git-workflow.md        # Git 流程
│   │   ├── quality.md             # 驗證與品質
│   │   └── auto-sync.md           # Hook 同步機制
│   ├── agents/
│   │   ├── researcher.md          # Haiku — 通用搜尋、收集資料
│   │   ├── architecture-explorer.md # Haiku — 架構探索、模組映射
│   │   ├── implementer.md         # Sonnet — 實作、驗證
│   │   ├── test-writer.md         # Sonnet — 測試撰寫、邊界覆蓋
│   │   ├── security-reviewer.md   # Sonnet — 安全審查、漏洞偵測
│   │   └── reviewer.md            # Opus — 架構決策、策略建議
│   └── skills/
│       ├── deep-review/SKILL.md   # 三維度平行審查（安全+效能+風格）
│       ├── frontend-design/SKILL.md # 前端設計指引（避免 AI slop）
│       ├── blog-analyzer/SKILL.md # Blog 文章分析，提取可操作洞察
│       ├── agent-team/SKILL.md    # 多 Worker 平行協作模式
│       └── cost-tracker/SKILL.md  # Token 使用量與花費追蹤
├── docs/
│   ├── INDEX.md                   # 進階文件索引（lazy-load 入口）
│   ├── advisor-strategy.md        # Advisor 模式完整說明
│   ├── blog-analysis-report.md    # Blog 文章分析報告
│   ├── workspace-performance-report.md # 效能報告（成本 -72.4%）
│   ├── stream-timeout-investigation.md # Stream timeout 調查
│   └── timeout-settings-impact-analysis.md # Timeout 設定影響分析
├── prompts.md                     # 萬用 Prompt 集（各情境開場 Prompt）
├── CLAUDE.md                      # 精簡主指令（≤ 50 行，rules 按需載入）
├── Memory.md                      # 跨對話記憶摘要（上下文保存與恢復）
├── CHANGELOG.md                   # 專案變更紀錄
└── README.md                      # 本文件
```

## 進階文件索引

`docs/` 內的深度文件為 **lazy-load** 模式 — 不會自動載入到主 context，請參考 [`docs/INDEX.md`](docs/INDEX.md) 查找適合場景，主動 `Read` 取用。

## 核心配置說明

### CLAUDE.md

依據 [Claude Code 官方最佳實踐](https://code.claude.com/docs/en/best-practices) 撰寫，包含：

| 區塊 | 用途 |
|------|------|
| 語言規則 | 依使用者語言自動切換回覆語系 |
| Sub Agent 策略與 Advisor 模式 | 三層 Agent（Haiku→Sonnet→Opus）+ 自訂 Sub Agent |
| Context Window 管理 | 70% 預警、Memory.md 摘要、compaction 指引 |
| Git 工作流程 | 完整的 commit → push → merge 流程與重試機制 |
| 驗證與品質 | 測試優先、lint 檢查、UI 截圖比對 |

### Memory.md

記錄每次對話的工作進度、已修改檔案、關鍵決策與下一步待辦，確保跨對話無縫接續。

### CHANGELOG.md

追蹤所有專案變更，格式為日期 + 分類（新增 / 優化 / 修復）+ 變更摘要。

## 使用方式

### 本機端（CLI / Desktop）

1. **Clone 此 repo**
   ```bash
   git clone https://github.com/zeuikli/claude-code-workspace.git
   cd claude-code-workspace
   ```

2. **設定全域載入**（讓所有專案都自動套用此指令）
   ```bash
   mkdir -p ~/.claude
   cat > ~/.claude/CLAUDE.md << 'EOF'
   @~/claude-code-workspace/CLAUDE.md
   @~/claude-code-workspace/Memory.md
   EOF
   ```

3. **啟動 Claude Code** — 在任何專案執行 `claude` 即會自動載入。

### 雲端 / 手機（claude.ai/code）

雲端 VM 每次 session 都是全新環境，`~/.claude/` 不會保留。本專案透過 **SessionStart Hook** 自動處理：

1. **開啟此專案** — 在 claude.ai/code 連接此 GitHub repo
2. **自動初始化** — session 啟動時，Hook 會自動：
   - Clone 此 repo 到 `/tmp/claude-code-workspace`
   - 建立 `~/.claude/CLAUDE.md` 並引用所有指令檔
3. **跨專案共用** — 在其他專案的 `.claude/settings.json` 加入相同的 SessionStart Hook 即可：
   ```json
   {
     "hooks": {
       "SessionStart": [
         {
           "matcher": "",
           "hooks": [
             {
               "type": "command",
               "command": "bash -c 'git clone --quiet https://github.com/zeuikli/claude-code-workspace.git /tmp/claude-code-workspace 2>/dev/null; mkdir -p ~/.claude; echo \"@/tmp/claude-code-workspace/CLAUDE.md\" > ~/.claude/CLAUDE.md; echo \"@/tmp/claude-code-workspace/Memory.md\" >> ~/.claude/CLAUDE.md'"
             }
           ]
         }
       ]
     }
   }
   ```

## 自動化同步機制

本專案內建完整的自動化流程，確保所有 session 讀取最新設定、Memory.md 變更自動回傳：

```
┌─────────────────────────────────────────────────────────┐
│                    Session 啟動                          │
│                        ↓                                │
│   session-init.sh 執行（SessionStart Hook）              │
│   ├── 本機：git pull 最新版本                             │
│   ├── 雲端：git clone 到 /tmp/claude-code-workspace      │
│   └── 確保 ~/.claude/CLAUDE.md 存在且正確引用             │
│                        ↓                                │
│   Claude Code 載入 CLAUDE.md + Memory.md                 │
│                        ↓                                │
│                   正常工作中...                           │
│                        ↓                                │
│   讀取 Memory.md（PreToolUse Hook）                       │
│   └── memory-pull.sh：從 GitHub 拉取最新版本              │
│                        ↓                                │
│   Memory.md 被修改（PostToolUse Hook）                    │
│   └── memory-update-hook.sh → memory-sync.sh             │
│       └── 自動 commit + push 回 GitHub                   │
└─────────────────────────────────────────────────────────┘
```

### 在其他專案啟用自動載入

在任何專案的 `.claude/settings.json` 加入以下內容，即可自動載入 workspace 設定：

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'REPO=https://github.com/zeuikli/claude-code-workspace.git; DIR=/tmp/claude-code-workspace; if [ -d $DIR/.git ]; then git -C $DIR pull -q origin main; else git clone -q --depth 1 $REPO $DIR; fi; mkdir -p ~/.claude; echo \"@${DIR}/CLAUDE.md\" > ~/.claude/CLAUDE.md; echo \"@${DIR}/Memory.md\" >> ~/.claude/CLAUDE.md'"
          }
        ]
      }
    ]
  }
}
```

## 自訂與擴展

- 編輯 `CLAUDE.md` 加入你的專案特定規則（建議保持精簡）
- 在 `.claude/skills/` 建立 Skill 檔案，擴展特定領域知識
- 在 `.claude/agents/` 建立自訂 Sub Agent，處理專門任務
- 透過 `.claude/settings.json` 設定 Hooks，實現自動化動作

## 授權

MIT License
