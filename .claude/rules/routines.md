---
description: Claude Code Routines — 排程 / API / GitHub webhook 自動化
tier: ondemand
source: "https://claude.com/blog/introducing-routines-in-claude-code (archive: archive/articles/introducing-routines-in-claude-code.md)"
---

# Routines（Claude Code 排程自動化）

> **Research preview**（2026-04-14 起），適用於 Pro / Max / Team / Enterprise 且已啟用 Claude Code on the web 的方案。

## 什麼是 Routine？

單次配置 → 反覆執行的 Claude Code 自動化。包含：prompt、repo、connectors。

跑在 Claude Code 雲端基礎設施 — **不依賴本機 terminal 開著**。

## 三種觸發方式

### 1. 排程 Routines（Scheduled）

指定 cadence：`hourly` / `nightly` / `weekly`。

```
Every night at 2am: pull the top bug from Linear, attempt a fix, and open a draft PR.
```

CLI 入口：`/schedule`

**常見模式**：
- **Backlog 夜間分診**：新 issue 自動貼標、指派、Slack 摘要
- **Docs drift 週檢**：掃過去一週合併的 PR、標出 API 變更對應文件、開修正 PR

### 2. API Routines

每個 routine 有獨立 endpoint + auth token。POST message → 收到 session URL。

```
Read the alert payload, find the owning service, and post a triage summary to #oncall with a proposed first step.
```

**常見模式**：
- **Deploy 驗證**：CD pipeline 每次部署後呼叫 → Claude 跑 smoke test → 回貼 go/no-go
- **Alert 分診**：Datadog 指向 routine endpoint → Claude 拉 trace、對照最近部署、準備 draft fix
- **Feedback 處理**：Docs feedback widget 回報 → Claude 開 session + issue context → 起草修改

### 3. GitHub Webhook Routines

訂閱 GitHub repo 事件，每個符合條件的 PR 開獨立 session。

```
Please flag PRs that touch the /auth-provider module. Any changes to this module need to be summarized and posted to #auth-changes.
```

**常見模式**：
- **SDK port**：Python SDK 合併 PR → 自動 port 到 Go SDK、開配對 PR
- **客製 code review**：PR 開啟時自動跑團隊 checklist（安全 + 效能）、留 inline 留言

## 使用限額

| 方案 | 每日 routine 上限 |
|------|----------------|
| Pro | 5 |
| Max | 15 |
| Team / Enterprise | 25 |

超量可購買 extra usage。Routine 用量也計入訂閱額度。

## 與本 workspace 的整合建議

1. **Backlog dispatch**：用 scheduled routine 每天自動讀取 TODO、GitHub issues，合併摘要貼 Slack。
2. **Deep review 自動化**：PR 開啟時 webhook routine 觸發 `/deep-review` Skill（`.claude/skills/deep-review/`）。
3. **Blog drift 追蹤**：weekly routine 執行 `blog-analyzer` Skill（`.claude/skills/blog-analyzer/`）檢查 Anthropic 新文章，對照 workspace 設定產出 diff。

## 設定位置

- 建立 / 管理：<https://claude.ai/code> 或 CLI `/schedule`
- 每個 routine 視為一個 Claude Code session，依同樣方式計費與套用 CLAUDE.md。

## Slack 整合 — @Claude 直接路由到 Claude Code（Thariq @trq212 驗證）

> 來源：[Claude Code in Slack 官方文件](https://code.claude.com/docs/en/slack)
> Thariq：「Anthropic 內部和外界最大的差異之一，就是大量在 Slack 裡使用 Claude Code」

### 運作方式

在 Slack channel @Claude → 自動偵測是否為程式任務 → 建立 Claude Code on the web session → 回報進度到 Slack thread

```
Slack thread 提供的 context（bug 討論、error log）→ Claude Code session（調查 + 修復）→ PR 連結回 Slack
```

### 兩種路由模式

| 模式 | 說明 | 適用情境 |
|------|------|---------|
| **Code only** | 所有 @mention 路由到 Claude Code | 技術團隊 |
| **Code + Chat** | Claude 判斷是程式任務或一般問答 | 混合型團隊 |

> 若路由到 Chat 但你想要 Code session：點「Retry as Code」；反之亦然。

### Anthropic 內部使用情境

- Bug 回報進 Slack → @Claude 調查修復 → 開 PR（非同步，不需離開 Slack）
- 「這個功能是什麼時候加的？」→ Claude 透過 git history 回答
- 「這段程式碼是誰負責的？」→ Claude 分析 blame / log

### 設定前提

- Pro / Max / Team / Enterprise + Claude Code on the web 已啟用
- GitHub 帳號已連接，且至少一個 repo 已認證
- Slack workspace 管理員需先安裝 Claude app

## Boris Cherny 驗證的 CLI 自動化技巧

> 來源：[shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice)（2026-03-30 驗證）

### `/loop` — 本地定期重複執行

在本機 terminal session 中定期呼叫某個 slash command：

```bash
/loop 5m /babysit
```

**適用情境**：長時間 CI 監控、定期輪詢 API 狀態 — 不需要雲端 Routines，terminal 開著即可。

**與 Routines 的差異**：`/loop` 依賴本機 terminal；Routines 在雲端跑，terminal 可以關掉。

### `/batch` — 平行遷移 fan-out

對一組相似目標（多個 repo / 多個模組）同時啟動平行 migration：

```bash
/batch migrate all Python 2 modules to Python 3
```

Claude 自動 fan-out 多個 worktree agent，各自處理一個目標，完成後合併結果。

### `--bare` 旗標 — 非互動 SDK 用途

```bash
claude --bare "your prompt here"
```

- 禁用互動 UI，啟動速度最高 **10x**。
- 適合 CI pipeline、webhook handler、腳本呼叫 — 任何不需要使用者介入的場景。

## Remote Control — 從任何設備繼續本地 Session（官方驗證）

> 來源：[code.claude.com/docs/en/remote-control](https://code.claude.com/docs/en/remote-control)（2026-04-18 fetch 驗證）
> 需要 Claude Code v2.1.51+；所有方案可用（Team/Enterprise 需管理員開啟）

Claude Code 繼續跑在**本地機器**，手機 / 瀏覽器只是遠端視窗。

### 三種啟動方式

```bash
# 1. Server mode（多 session 並發，最大 32 個）
claude remote-control

# 2. Interactive session（本機也能打字，同時可遠端）
claude --remote-control
claude --remote-control "My Project"

# 3. 在已有 session 中啟動
/remote-control
/rc
```

### 從另一台設備連線

- 直接用 session URL 開啟 claude.ai/code
- 掃 QR code（按空白鍵顯示）→ Claude mobile app
- `/mobile` 指令顯示 iOS / Android 下載 QR code

### Mobile 推播通知（v2.1.110+）

- `/config` 啟用 **Push when Claude decides**
- 適合長時間任務：任務完成或需要決策時推播

### 與 Claude Code on the web 的差異

| | Remote Control | Claude Code on the web |
|---|---|---|
| 執行位置 | 本地機器 | Anthropic 雲端 |
| 本地 MCP / 工具 | ✅ 可用 | ❌ 不可用 |
| 適用情境 | 在外繼續手上的工作 | 無本地環境時啟動新任務 |

## Channels — Telegram / Discord / iMessage 整合

> 來源：[code.claude.com/docs/en/channels](https://code.claude.com/docs/en/channels)

在聊天 app 中觸發 Claude Code session，Claude 跑在本地機器。

```
# 安裝官方 channel plugin（Telegram / Discord）
/plugin install telegram
/plugin install discord

# 或自訂 channel（HTTP endpoint）
```

**常見模式**：
- CI 失敗推送到 Telegram → @Claude 診斷 + 開 draft fix
- Discord 頻道回報 bug → Claude 調查並回報進度
- 比 Slack 整合輕量：不需要 claude.ai/code 帳號的雲端路由
