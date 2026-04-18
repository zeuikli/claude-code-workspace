# 預設研究來源 | Default Research Sources

> 最後更新：2026-04-18 — 本輪研究已驗證所有連結可存取

## 官方一手來源（Primary Sources）

| 來源 | 說明 |
|------|------|
| https://code.claude.com/docs/en/hooks | 完整 Hook 事件清單（25 種，含 exit code 規約）|
| https://code.claude.com/docs/en/best-practices | 官方最佳實踐總覽 |
| https://code.claude.com/docs/en/memory | Auto Memory + CLAUDE.md 結構 |
| https://code.claude.com/docs/en/routines | Routines（排程 / API / GitHub webhook）|
| https://code.claude.com/docs/en/mcp | MCP 整合指南 |
| https://claude.com/blog | Anthropic 官方 blog（最新功能公告）|

## 社群驗證來源（Community — 本輪驗證可存取）

| Repo | 重點內容 | 驗證日期 |
|------|----------|---------|
| [shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice) | Boris Cherny 15 tips（2026-03-30）+ 6 tips（2026-04-16）| 2026-04-18 |
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | 75+ 社群 repo 策展清單 | 未直接驗證 |
| [ykdojo/claude-code-tips](https://github.com/ykdojo/claude-code-tips) | Minimal CLAUDE.md 原則 | 未直接驗證 |

## Boris Cherny 驗證 Tips（2026-03-30，已逐項驗證）

從 `shanraisshan/claude-code-best-practice` 驗證的高價值模式：

| Tips | 重點 | 對應 workspace 位置 |
|------|------|-------------------|
| `/branch` — session forking | `claude --resume <id> --fork-session` 探索不同方向 | session-management.md |
| `/btw` — side query | 非阻塞式提問，不中斷 agent 進度 | session-management.md |
| `/loop` — recurring tasks | `/loop 5m /babysit` 定期自動執行 | routines.md |
| `/batch` — parallel migration | fan-out 到多個 worktree agent | subagent-strategy.md |
| `--bare` flag | 非互動 SDK 用途，啟動速度最高 10x | cli-enhancers.md |
| `WorktreeCreate` hook | 為 worktree 初始化非 git VCS 環境 | auto-sync.md |
| `--add-dir` / `/add-dir` | 多 repo 同時可見，跨目錄授權 | cli-enhancers.md |

## 未驗證 / 疑似幻覺（研究 Agent 產出，勿直接引用）

- "AutoDream" — 未找到官方文件
- 具體效能數字（"20%→50% skill activation"）— 無一手來源
- "PostToolUseFailure" 早期報告為假，但已被**官方文件驗證為真實事件**

## 下次審計建議查詢詞

```
site:github.com claude code CLAUDE.md best practices 2026
site:reddit.com/r/ClaudeAI claude code workflow tips
site:news.ycombinator.com claude code hooks skills
claude code Boris Cherny tips 2026
```
