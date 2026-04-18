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
| https://code.claude.com/docs/en/skills | Skills 官方文件（格式 / 類型 / 設計原則）|
| https://code.claude.com/docs/en/permissions | 權限系統 + Wildcard 語法 |
| https://code.claude.com/docs/en/sandbox | Sandboxing 開源 runtime |
| https://code.claude.com/docs/en/statusline | Status Line 自訂 |
| https://code.claude.com/docs/en/settings | 37 settings + 84 環境變數完整清單 |
| https://claude.com/blog | Anthropic 官方 blog（最新功能公告）|

## Boris Cherny (@bcherny) — 全部已驗證文件（時序）

> Boris Cherny 是 Claude Code 創始人（Anthropic）。所有文件已直接 fetch 驗證。

| 日期 | 檔案 | 核心洞察 | Workspace 狀態 |
|------|------|----------|----------------|
| 2026-01-03 | [claude-boris-13-tips-03-jan-26.md](https://github.com/shanraisshan/claude-code-best-practice/blob/main/tips/claude-boris-13-tips-03-jan-26.md) | 5 個平行 Claude、Plan Mode、Tag @claude on PRs、PostToolUse 自動格式化、MCP（Slack/BigQuery/Sentry）、背景 agent 驗證 | ⚠️ 部分採納 |
| 2026-02-01 | [claude-boris-10-tips-01-feb-26.md](https://github.com/shanraisshan/claude-code-best-practice/blob/main/tips/claude-boris-10-tips-01-feb-26.md) | Git worktrees 平行、"Knowing everything you know now, scrap this" prompt、Ghostty terminal、"use subagents" 指令、資料分析 | ⚠️ 部分採納 |
| 2026-02-12 | [claude-boris-12-tips-12-feb-26.md](https://github.com/shanraisshan/claude-code-best-practice/blob/main/tips/claude-boris-12-tips-12-feb-26.md) | Wildcard 權限（`Bash(bun run *)`、`Edit(/docs/**)`）、Sandboxing（`/sandbox`）、Plugin marketplace（`/plugin`）、Output styles（Explanatory/Learning）、37 settings | ⚠️ 部分採納 |
| 2026-03-10 | [claude-boris-2-tips-10-mar-26.md](https://github.com/shanraisshan/claude-code-best-practice/blob/main/tips/claude-boris-2-tips-10-mar-26.md) | Code Review（多 agent PR 審查）、Test Time Compute（多個不相關 context windows）| ✅ 概念在 deep-review |
| 2026-03-25 | [claude-boris-2-tips-25-mar-26.md](https://github.com/shanraisshan/claude-code-best-practice/blob/main/tips/claude-boris-2-tips-25-mar-26.md) | Always squash merge、PR size p50=118 lines / p90=498 lines | 📝 參考 |
| 2026-03-30 | [claude-boris-15-tips-30-mar-26.md](https://github.com/shanraisshan/claude-code-best-practice/blob/main/tips/claude-boris-15-tips-30-mar-26.md) | /branch、/btw、/loop、/batch、--bare、WorktreeCreate hook、--add-dir | ✅ **已採納** |
| 2026-04-16 | [claude-boris-6-tips-16-apr-26.md](https://github.com/shanraisshan/claude-code-best-practice/blob/main/tips/claude-boris-6-tips-16-apr-26.md) | Auto Mode（Shift+Tab）、/fewer-permission-prompts、Recaps、/focus、Effort 五層、/go 驗證模式 | ✅ **已採納** |

## Thariq (@trq212) — 全部已驗證文件（時序）

> Thariq 是 Anthropic Claude Code 核心團隊成員。所有文件已直接 fetch 驗證。

| 日期 | 檔案 | 核心洞察 | Workspace 狀態 |
|------|------|----------|----------------|
| 2026-03-17 | [claude-thariq-tips-17-mar-26.md](https://github.com/shanraisshan/claude-code-best-practice/blob/main/tips/claude-thariq-tips-17-mar-26.md) | 9 種 Skill 類型、9 個 Skill 設計 Tips（T1-T9）：description=trigger、${CLAUDE_PLUGIN_DATA}、On-demand Hooks、Progressive Disclosure | ✅ **已採納**（add-skill/SKILL.md）|
| 2026-04-16 | [claude-thariq-tips-16-apr-26.md](https://github.com/shanraisshan/claude-code-best-practice/blob/main/tips/claude-thariq-tips-16-apr-26.md) | Session 管理深度指南：Context rot ~300-400k tokens、Context carry-forward 光譜、Rewind > 口頭修正、Bad compact 成因、Subagent mental test | ✅ **已採納**（session-management.md）|

## Boris Cherny 完整 Tips 對照表（已採納項目）

| Tips | 重點 | 對應 workspace 位置 |
|------|------|-------------------|
| `/branch` — session forking | `claude --resume <id> --fork-session` 探索不同方向 | session-management.md |
| `/btw` — side query | 非阻塞式提問，不中斷 agent 進度 | session-management.md |
| `/focus` — focus mode | 隱藏中間工具輸出，只看最終結果 | session-management.md |
| Recaps | 回到 session 時自動顯示摘要 | session-management.md |
| `/loop` — recurring tasks | `/loop 5m /babysit` 定期自動執行 | routines.md |
| `/batch` — parallel migration | fan-out 到多個 worktree agent | routines.md |
| `--bare` flag | 非互動 SDK 用途，啟動速度最高 10x | routines.md |
| `WorktreeCreate` hook | 為 worktree 初始化非 git VCS 環境 | auto-sync.md |
| `--add-dir` / `/add-dir` | 多 repo 同時可見，跨目錄授權 | cli-enhancers.md |
| PostToolUse auto-format | `bun run format` 在 Edit/Write 後自動執行 | auto-sync.md（已記錄）|
| Auto Mode（Shift+Tab） | classifier 自動批准安全命令 | opus47-best-practices.md |

## Thariq 完整 Skill 設計原則（T1–T9）

| 原則 | 說明 | Workspace 位置 |
|------|------|----------------|
| T1 | 別說廢話 — 只寫 Claude 不知道的事 | add-skill/SKILL.md（反模式）|
| T2 | Gotchas 是最高信噪比的內容 — 從失敗案例持續更新 | add-skill/SKILL.md（驗證清單）|
| T3 | Skill 是資料夾不只是 markdown — Progressive Disclosure | add-skill/SKILL.md（Step 3）|
| T4 | 別硬規定步驟 — 給目標與限制，讓 Claude 靈活 | add-skill/SKILL.md（反模式）|
| T5 | 用 `config.json` 存設定 — 未設定時詢問使用者 | add-skill/SKILL.md（Step 3）|
| T6 | description 是給模型看的 — 寫觸發條件不是功能摘要 | add-skill/SKILL.md（描述規則）|
| T7 | `${CLAUDE_PLUGIN_DATA}` — skill 跨 session 資料的穩定路徑 | add-skill/SKILL.md（Step 3）|
| T8 | 在 scripts/ 放腳本讓 Claude 組合，不從頭寫 boilerplate | add-skill/SKILL.md（Step 3）|
| T9 | On-demand Hooks — skill 啟動時才生效，session 結束即移除 | add-skill/SKILL.md（On-demand Hooks）|

## 社群驗證來源（Community）

| Repo | 重點內容 | 驗證日期 |
|------|----------|---------|
| [shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice) | Boris + Thariq tips（2026-01 至 2026-04）| 2026-04-18 |
| [howborisusesclaudecode.com](https://howborisusesclaudecode.com) | 粉絲整理 87 個 Boris tips | 2026-04-18 |
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | 75+ 社群 repo 策展清單 | 未直接驗證 |
| [ykdojo/claude-code-tips](https://github.com/ykdojo/claude-code-tips) | Minimal CLAUDE.md 原則 | 未直接驗證 |

## 未驗證 / 疑似幻覺（研究 Agent 產出，勿直接引用）

- "AutoDream" — 未找到官方文件
- 具體效能數字（"20%→50% skill activation"）— 無一手來源
- "Prompt Caching Is Everything" by Thariq — 標題存在但完整內容未驗證
- Mobile `/teleport`、`/remote-control` — 未找到官方文件

## 下次審計建議查詢詞

```
site:github.com/shanraisshan/claude-code-best-practice tips
site:x.com bcherny claude 2026
site:x.com trq212 claude 2026
howborisusesclaudecode.com
site:github.com bcherny claude
```
