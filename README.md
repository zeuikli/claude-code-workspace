# Claude Code Workspace

> **繁體中文** · [English below](#english)

針對 [Claude Code](https://code.claude.com) 優化的個人工作區 — 內建四層載入框架、雙語支援、Advisor 模式與全域自動化 Hooks。

---

## 快速開始

將以下指令貼進任何 Claude Code session 即可套用所有設定：

```bash
請執行：DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; command -v git >/dev/null 2>&1 && (([ -d "$DIR/.git" ] && git -C "$DIR" pull -q origin main 2>/dev/null || ([ -n "$DIR" ] && rm -rf "$DIR"; git clone --depth 1 --filter=blob:none -q https://github.com/zeuikli/claude-code-workspace.git "$DIR" || { echo "⚠️ Clone failed" >&2; exit 1; })) && mkdir -p ~/.claude && printf "@${DIR}/CLAUDE.md\n" > ~/.claude/CLAUDE.md)

完成後讀取並遵循 ${DIR}/CLAUDE.md
```

完成後執行 `/load-plan` 查看所有可用工具與 token 成本。

---

## 四層載入框架

`/load-plan` 的設計依據 — 每層有明確的目的與成本：

| 層級 | 觸發 | 內容 | 預估成本 |
|------|------|------|---------|
| 🔴 **真實載入** | SessionStart Hook | `session-init.sh` + `CLAUDE.md` 本體 | ~708 tok |
| 🟡 **自動載入** | 每次 session | `core.md` + `subagent-strategy.md` + `context-management.md` | ~1,184 tok |
| 🟢 **按需載入** | 說出觸發詞 | 16 skills + 6 rules（按需，說了才載入）| 0 ～ 2,000 tok |
| ⚪ **不必載入** | 手動 Read | docs/archive、reference docs | — |

**設計原則**：每次 session 固定消耗 ~1,892 tokens（CLAUDE.md ~423 + 3 rules ~1,184 + 85% cache 折扣後實付 ~284），其餘零成本直到真正需要。

---

## 涵蓋領域

| 領域 | 指令 | 適用情境 |
|------|------|---------|
| 🖥 程式開發 | `/debug` `/perf` `/map` `/deep-review` `/frontend-design` | 除錯、效能、重構、UI |
| 📣 行銷策略 | `/marketing` | GTM、A/B 測試、競品分析 |
| ✍️ 文案撰寫 | `/writing` | 文案、SEO、Email、Landing Page |
| 🔍 研究分析 | `/research` `/research-best-practices` | 市場調查、文獻整理 |
| 📋 專案管理 | `/pm` `/agent-team` | Sprint、狀態報告、多 Agent |
| 🔧 Workspace | `/prime` `/retro` `/context-report` `/load-plan` | 冷啟、回顧、成本分析 |

---

## 效能優化

| 優化項目 | 效果 |
|---|---|
| Fetch 時間戳快取（TTL=300s）| 暖啟動 20–40ms（vs 300–800ms，-88%）|
| Sparse-checkout 初始 clone | 傳輸量 -40–60%，初始 clone 500–800ms（vs 1,000–1,500ms）|
| DEDUP 雙重載入保護 | workspace 本體執行時節省 ~708 tok |
| O(1) stat 日誌大小檢查 | 每次 prompt hook 省 ~18ms vs O(n) wc -l |

---

## 核心架構

### Advisor 模式（三層模型）

| 角色 | 模型 | 職責 |
|------|------|------|
| 執行者 | Sonnet 4.6 | 日常任務：實作、測試、搜尋 |
| 搜尋 | Haiku 4.5 | 探索 10+ 檔案的研究任務 |
| 顧問 | Opus 4.7 | 僅在架構決策、安全審計、邊界判斷時介入 |

### 自動化 Hooks（10 種事件）

| Hook | 用途 |
|------|------|
| `SessionStart` | 拉取最新設定；防止 double-load（當專案即 workspace 時） |
| `UserPromptSubmit` | 注入 Sub Agent 委派提醒 |
| `PreToolUse(bash)` | Commit 前強制執行 `/deep-review` |
| `PostToolUse(Edit/Write)` | 自動驗證 .sh/.json/.py 語法 |
| `PreCompact/PostCompact` | Auto Memory 保存提醒 |

### 記憶管理

- **官方 Auto Memory**（`autoMemoryEnabled: true`）— 跨 session 自動累積，`/memory` 查看
- `/compact <hint>` 壓縮時 Auto Memory 不受影響

---

## 本機安裝

```bash
git clone https://github.com/zeuikli/claude-code-workspace.git
cd claude-code-workspace
mkdir -p ~/.claude
echo "@~/claude-code-workspace/CLAUDE.md" > ~/.claude/CLAUDE.md
```

## 跨專案共用

任何專案的 `.claude/settings.json` 加入 SessionStart Hook：

```json
{
  "hooks": {
    "SessionStart": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "bash -c 'DIR=/tmp/claude-code-workspace; [ -d \"$DIR/.git\" ] && git -C \"$DIR\" pull -q origin main 2>/dev/null || { [ -n \"$DIR\" ] && rm -rf \"$DIR\"; git clone --depth 1 --filter=blob:none -q https://github.com/zeuikli/claude-code-workspace.git \"$DIR\" || { echo \"⚠️ Clone failed\" >&2; exit 1; }; }; mkdir -p ~/.claude; printf \"@${DIR}/CLAUDE.md\n\" > ~/.claude/CLAUDE.md'"
      }]
    }]
  }
}
```

設定完成後，快速啟動會在前 5 分鐘內命中 fetch 時間戳快取，重啟時暖啟動延遲僅 20–40ms。

---

## 分支說明

| 分支 | 用途 |
|------|------|
| `main` | 穩定的日常工作環境（預設使用） |
| `blog-archive` | Anthropic 官方部落格歸檔（知識來源） |

---

<a name="english"></a>

## English

A personal [Claude Code](https://code.claude.com) workspace with a **4-tier load framework**, bilingual support (Traditional Chinese first, English second), Advisor Strategy, and automated hooks.

### Quick Start

Paste into any Claude Code session:

```bash
DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; command -v git >/dev/null 2>&1 && (([ -d "$DIR/.git" ] && git -C "$DIR" pull -q origin main 2>/dev/null || ([ -n "$DIR" ] && rm -rf "$DIR"; git clone --depth 1 --filter=blob:none -q https://github.com/zeuikli/claude-code-workspace.git "$DIR" || { echo "⚠️ Clone failed" >&2; exit 1; })) && mkdir -p ~/.claude && printf "@${DIR}/CLAUDE.md\n" > ~/.claude/CLAUDE.md)
```

Then run `/load-plan` to see all available tools with token cost estimates.

### Performance Optimizations

| Optimization | Impact |
|---|---|
| Fetch timestamp caching (TTL=300s) | Warm-start 20–40ms (vs 300–800ms, -88%) |
| Sparse-checkout initial clone | Transport -40–60%, init 500–800ms (vs 1,000–1,500ms) |
| DEDUP protection against double-load | Saves ~708 tok when workspace is the project itself |
| O(1) stat for log size check | ~18ms faster per prompt hook vs O(n) wc -l |

### 4-Tier Load Framework

| Tier | Trigger | Content | Est. Cost |
|------|---------|---------|-----------|
| 🔴 **Real-time** | SessionStart Hook | `session-init.sh` + `CLAUDE.md` | ~708 tok |
| 🟡 **Auto** | Every session | 3 core rules (language/git/subagent/context) | ~1,184 tok |
| 🟢 **On-demand** | Say trigger keyword | 16 skills + 6 rules | 0–2,000 tok |
| ⚪ **Skip** | Manual Read only | docs/archive, reference docs | — |

**Design principle**: Fixed overhead of ~1,892 tokens per session (~284 effective with 85% prompt caching). Everything else costs zero until needed.

### Domain Coverage

| Domain | Commands | Use Cases |
|--------|----------|-----------|
| 🖥 Development | `/debug` `/perf` `/map` `/deep-review` `/frontend-design` | Bugs, performance, refactoring, UI |
| 📣 Marketing | `/marketing` | Campaigns, GTM, A/B testing, competitive analysis |
| ✍️ Content | `/writing` | Copywriting, SEO, email marketing, landing pages |
| 🔍 Research | `/research` `/research-best-practices` | Market research, literature reviews |
| 📋 PM | `/pm` `/agent-team` | Sprints, status reports, multi-agent tasks |
| 🔧 Workspace | `/prime` `/retro` `/context-report` `/load-plan` | Cold-start, retro, cost analysis |

### Advisor Strategy (3-Tier Model)

| Role | Model | Responsibility |
|------|-------|---------------|
| Executor | Sonnet 4.6 | Daily tasks: implementation, testing, search |
| Explorer | Haiku 4.5 | Research tasks spanning 10+ files |
| Advisor | Opus 4.7 | Architecture decisions, security audits only |

### Cross-Project Usage

Add SessionStart Hook to any project's `.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "bash -c 'DIR=/tmp/claude-code-workspace; [ -d \"$DIR/.git\" ] && git -C \"$DIR\" pull -q origin main 2>/dev/null || { [ -n \"$DIR\" ] && rm -rf \"$DIR\"; git clone --depth 1 --filter=blob:none -q https://github.com/zeuikli/claude-code-workspace.git \"$DIR\" || { echo \"⚠️ Clone failed\" >&2; exit 1; }; }; mkdir -p ~/.claude; printf \"@${DIR}/CLAUDE.md\n\" > ~/.claude/CLAUDE.md'"
      }]
    }]
  }
}
```

After setup, fast restarts within 5 minutes hit the fetch timestamp cache for just 20–40ms warm-start latency.

### Local Install

```bash
git clone https://github.com/zeuikli/claude-code-workspace.git
mkdir -p ~/.claude
echo "@~/claude-code-workspace/CLAUDE.md" > ~/.claude/CLAUDE.md
```

---

## License

MIT License
