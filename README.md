# Claude Code Workspace

針對 [Claude Code](https://code.claude.com) 優化的個人開發工作區 — **Opus 4.7 + Sonnet 4.6 雙模型強化版**，內建專案指令、對話記憶管理與自動化工作流程配置。

## 版本更新（2026-04-17）

- ✨ 全面導入 **Opus 4.7** 最佳實踐（`xhigh` effort、自適應思考、task-upfront pattern）
- ✨ 新增 `session-management` 規則 — 涵蓋 `/rewind` / `/compact` / `/clear` / subagent 決策表
- ✨ 新增 `routines` 規則 — 支援 Claude Code 排程 / API / GitHub webhook 自動化
- ✨ 新增 `docs/opus47-migration.md` — 從 4.6 升級的完整 diff 與操作清單
- 🔧 `settings.json` 加入 `model` / `effortLevel` / `alwaysThinkingEnabled` / `advisorModel`

## 分支說明

| 分支 | 用途 | 說明 |
|------|------|------|
| `main` | **預設使用** | 穩定的日常工作環境 |
| `blog-archive` | 知識來源 | Anthropic 官方部落格歸檔（供改寫與對照）|
| `claude/rewrite-with-opus-sonnet-*` | 升級實驗 | Opus 4.7 / Sonnet 4.6 改寫分支 |

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

## Opus 4.7 亮點

- **`xhigh` 預設 effort** — 介於 `high` 和 `max` 之間的新等級，適合大多數 agentic 編碼任務。
- **自適應思考** — 取代固定 thinking budget；模型自行決定每步是否推理。
- **任務委派思維** — 把 Claude 當資深工程師：第一輪就給完整規格（意圖、限制、驗收條件、檔案路徑）。
- **更節制的 subagent** — 需要平行委派時要**明確指示**，不會自動 fan-out。
- **`/usage` 指令** — 查看 session token/cost 即時用量。
- **`/rewind` 習慣** — Claude 走錯方向時，比口頭修正更有效。

完整遷移步驟見 [`docs/opus47-migration.md`](docs/opus47-migration.md)。

## 專案概述

- **雙語自動回覆** — 中文 → 台灣繁體中文，英文 → 英文
- **Advisor 模式** — Sonnet 4.6 / Haiku 4.5 主迴圈，Opus 4.7 退居幕後當顧問
- **官方 Auto Memory** — Claude 自動記憶跨 session 知識（`autoMemoryEnabled: true`）
- **Routines 整合** — Scheduled / API / GitHub webhook 自動化工作流
- **Git 自動化** — 改動完成後自動 commit/push（4 次指數退避重試）

## 檔案結構

```
claude-code-workspace/
├── .github/workflows/ci.yml       # CI：shellcheck + JSON schema + markdown-lint
├── scripts/healthcheck.sh         # workspace 健康檢查
├── .claude/
│   ├── settings.json              # Opus 4.7 xhigh + 9 種 Hook + Auto Memory + Timeout
│   ├── hooks/                     # 9 種 hook 事件
│   ├── rules/
│   │   ├── language.md            # 語言回覆
│   │   ├── opus47-best-practices.md  # ★ Opus 4.7 調校指南
│   │   ├── subagent-strategy.md   # Sub Agent + Advisor 模式
│   │   ├── session-management.md  # ★ /rewind / /compact / /clear 決策表
│   │   ├── context-management.md  # Context 監控
│   │   ├── routines.md            # ★ Claude Code Routines
│   │   ├── git-workflow.md        # Git 自動化
│   │   ├── quality.md             # 測試與驗證
│   │   └── auto-sync.md           # 同步機制
│   ├── agents/
│   │   ├── researcher.md / architecture-explorer.md (Haiku 4.5)
│   │   ├── implementer.md / test-writer.md / security-reviewer.md / doc-writer.md (Sonnet 4.6)
│   │   └── code-reviewer.md / reviewer.md (Opus 4.7)
│   └── skills/
│       ├── deep-review / frontend-design / blog-analyzer
│       └── agent-team / cost-tracker
├── docs/
│   ├── INDEX.md
│   ├── advisor-strategy.md
│   └── opus47-migration.md        # ★ 4.6 → 4.7 遷移指引
├── prompts.md                     # 萬用 Prompt 集
├── CLAUDE.md                      # 精簡主指令（rules 按需載入）
└── CHANGELOG.md                   # 專案變更紀錄
```

## 核心配置

| 項目 | 說明 |
|------|------|
| `model: claude-opus-4-7` | 預設模型 |
| `effortLevel: xhigh` | Opus 4.7 推薦預設 |
| `alwaysThinkingEnabled: true` | 自適應思考 |
| `advisorModel: claude-opus-4-7` | Server-side advisor 也用 4.7 |
| `autoMemoryEnabled: true` | 官方 Auto Memory 跨 session 累積 |
| 9 種 Hook 事件 | SessionStart / InstructionsLoaded / UserPromptSubmit / SubagentStart / SubagentStop / PreToolUse / PreCompact / PostCompact / Stop |
| Timeout | Stream watchdog + 2min idle + 15min API + 30min Bash max |
| Sub Agent 三層 | Haiku 4.5（搜尋）→ Sonnet 4.6（實作）→ Opus 4.7（審查） |

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
