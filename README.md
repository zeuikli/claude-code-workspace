# Claude Code Workspace

針對 [Claude Code](https://code.claude.com) 優化的個人開發工作區，內建專案指令、對話記憶管理與自動化工作流程配置。

## 分支說明

| 分支 | 用途 | 說明 |
|------|------|------|
| `main` | **預設使用** | 穩定的日常工作環境，包含最新的 Hooks、Skills、Agents 與 CLAUDE.md 設定。 |
| `claude/karpathy-optimization-merged` | **研究分析** | 實驗分支，用於探索新策略、效能分析等研究性工作。 |

> 若無特殊需求，請使用 `main` 分支。

---

## 快速開始

將以下 Prompt 貼進任何 Claude Code session 即可立即套用所有設定：

```
請執行：DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; command -v git >/dev/null 2>&1 && (([ -d "$DIR/.git" ] && git -C "$DIR" pull -q origin main || (rm -rf "$DIR" 2>/dev/null; git clone --depth 1 -q https://github.com/zeuikli/claude-code-workspace.git "$DIR")) && mkdir -p ~/.claude && printf "@${DIR}/CLAUDE.md\n" > ~/.claude/CLAUDE.md)

完成後讀取並遵循 ${DIR}/CLAUDE.md（跨對話記憶由官方 Auto Memory 自動管理）
```

> **環境對照**：
>
> | | 電腦版 CLI / Desktop | 雲端版（iOS / Android / Web）|
> |---|---|---|
> | 偵測方式 | `CLAUDE_CODE_REMOTE` 不存在 | `CLAUDE_CODE_REMOTE=true` |
> | Clone 目標 | `~/claude-code-workspace`（持久）| `/tmp/claude-code-workspace`（session 內）|
> | 跨對話記憶 | 官方 Auto Memory（`~/.claude/projects/.../memory/`）| 同左 |

## 專案概述

- **雙語自動回覆** — 中文 → 台灣繁體中文，英文 → 英文
- **Advisor 模式** — Haiku/Sonnet 主迴圈，Opus 退居幕後當顧問
- **官方 Auto Memory** — Claude 自動記憶跨 session 知識（`autoMemoryEnabled: true`）
- **Git 自動化** — 改動完成後自動 commit/push

## 檔案結構

```
claude-code-workspace/
├── .github/workflows/ci.yml       # CI：shellcheck + JSON schema + markdown-lint
├── scripts/healthcheck.sh         # workspace 健康檢查
├── .claude/
│   ├── settings.json              # Hook（9 種事件）+ autoMemoryEnabled + Timeout 設定
│   ├── hooks/
│   │   ├── session-init.sh        # SessionStart：拉取最新指令（5MB threshold）
│   │   ├── instructions-loaded.sh # InstructionsLoaded：記錄載入時機
│   │   ├── user-prompt-submit.sh  # UserPromptSubmit：Sub Agent 提醒
│   │   ├── subagent-start.sh      # SubagentStart：監控 Advisor 策略
│   │   ├── subagent-stop.sh       # SubagentStop：記錄完成狀態
│   │   ├── pre-commit-review.sh   # PreToolUse(Bash)：提醒 deep-review
│   │   ├── pre-compact.sh         # PreCompact：壓縮前提醒
│   │   ├── post-compact.sh        # PostCompact：壓縮後恢復
│   │   └── session-stop.sh        # Stop：session 結束
│   ├── rules/
│   │   ├── language.md / subagent-strategy.md / context-management.md
│   │   ├── git-workflow.md / quality.md / auto-sync.md
│   ├── agents/
│   │   ├── researcher.md (Haiku) / architecture-explorer.md (Haiku) / doc-writer.md (Haiku)
│   │   ├── implementer.md (Sonnet) / test-writer.md (Sonnet) / security-reviewer.md (Sonnet)
│   │   └── code-reviewer.md (Opus) / reviewer.md (Opus)
│   └── skills/
│       └── deep-review / frontend-design / blog-analyzer / agent-team / cost-tracker
├── docs/                          # lazy-load 進階文件（不自動載入主 context）
├── prompts.md                     # 萬用 Prompt 集
├── CLAUDE.md                      # 精簡主指令（< 40 行，rules 按需載入）
├── Memory.md                      # 歷史記錄存檔（新記憶由 Auto Memory 管理）
└── CHANGELOG.md                   # 專案變更紀錄
```

## 核心配置

| 項目 | 說明 |
|------|------|
| `autoMemoryEnabled: true` | 官方 Auto Memory，跨 session 自動累積記憶 |
| 9 種 Hook 事件 | SessionStart / InstructionsLoaded / UserPromptSubmit / SubagentStart / SubagentStop / PreToolUse / PreCompact / PostCompact / Stop |
| Timeout 設定 | Stream watchdog + 2min idle + 15min API + 30min Bash max |
| Sub Agent 三層 | Haiku（搜尋）→ Sonnet（實作）→ Opus（審查） |

詳細文件見 [`docs/INDEX.md`](docs/INDEX.md)。

## 使用方式

### 本機端（CLI / Desktop）

```bash
git clone https://github.com/zeuikli/claude-code-workspace.git
cd claude-code-workspace
mkdir -p ~/.claude
echo "@~/claude-code-workspace/CLAUDE.md" > ~/.claude/CLAUDE.md
```

### 雲端（claude.ai/code）

SessionStart Hook 自動處理（每次 session 啟動時 clone + 建立 `~/.claude/CLAUDE.md`）。

### 跨專案共用

在任何專案的 `.claude/settings.json` 加入：

```json
{
  "hooks": {
    "SessionStart": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "bash -c 'DIR=/tmp/claude-code-workspace; [ -d $DIR/.git ] && git -C $DIR pull -q origin main || git clone -q --depth 1 https://github.com/zeuikli/claude-code-workspace.git $DIR; mkdir -p ~/.claude; echo \"@${DIR}/CLAUDE.md\" > ~/.claude/CLAUDE.md'"
      }]
    }]
  }
}
```

## 授權

MIT License
