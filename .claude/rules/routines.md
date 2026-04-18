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
