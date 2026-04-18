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

## 新功能（Research Preview + 正式功能，2026-Q1/Q2）

| 功能 | 版本 | 說明 | Workspace 狀態 |
|------|------|------|----------------|
| `/ultraplan` | v2.1.91+ | 雲端規劃：Claude 在雲端分析需求 → web review UI（inline comments / emoji / threads）→ teleport 回 terminal 執行 | ✅ 已加入 CLAUDE.md |
| `/ultrareview` | v2.1.86+ | 多 agent fleet 深度 code review；5–10 分鐘；Pro/Max 3 次免費，之後 $5–20/run | ✅ 已加入 deep-review/SKILL.md |
| **Remote Control** | v2.1.51+ | `claude remote-control` / `claude --remote-control` / `/remote-control` / `/rc`：從手機/瀏覽器控制本地 session；需 claude.ai 帳號 | ✅ 已加入 routines.md |
| **Channels** | — | `/en/channels`：Telegram / Discord / iMessage → Claude Code session；支援自訂 channel plugin | 📝 已加入 routines.md |
| Voice mode | Research Preview | `/voice` 或 `claude --voice`；支援即時語音對話控制 agent；Mobile app 優先 | 📝 參考，未加入 workspace |

> 來源：code.claude.com/docs/en/remote-control（直接 fetch 驗證）；Thariq Twitter/X；Anthropic blog

## Thariq 工程哲學（2026 年公開洞察）

| 主題 | 核心論點 | Workspace 位置 |
|------|----------|----------------|
| **Unhobbling the Model** | 持續移除不必要的限制，讓 Claude 有更多自主性 | spec-interview/SKILL.md（核心理念）|
| **Delete-and-Rebuild Cycle** | 模型能力提升後積極刪除舊 scaffolding；10x 能力 = 10x 刪除 | spec-interview/SKILL.md（核心理念）|
| **Competitive Advantage as Vector** | 方向 + 累積洞察是護城河，而非單一功能 | 未採納（商業哲學）|
| **Seeing like an Agent** | 從模型視角設計工具；AskUserQuestion 3 次失敗→成功設計過程 | spec-interview/SKILL.md（架構哲學）|
| **Context rot ~300-400k tokens** | 注意力稀釋閾值；依任務類型有差異 | context-management.md、session-management.md |

## 驗證狀態更新（2026-04-18 深度審計）

| 項目 | 原狀態 | 驗證結果 | 備註 |
|------|--------|----------|------|
| "AutoDream" | 未驗證 | ❌ **確認幻覺** | 無任何官方文件 |
| "20%→50% skill activation" | 未驗證 | ⚠️ **社群來源** | community blog 有提及，非官方數字，勿引用 |
| "Prompt Caching Is Everything" by Thariq | 標題存在，內容未驗證 | ✅ **已驗證** | Thariq Shihpar，2026-02-24，3 個核心觀點（static-first、prefix matching、per-model caching）。內容已涵蓋於 context-management.md |
| Mobile `/teleport` | 未驗證 | ❌ **確認幻覺** | 官方文件無此指令；連接手機的正確方式是 `/remote-control` + QR code |
| `/remote-control` | 未驗證 | ✅ **已驗證** | 完整官方文件 code.claude.com/docs/en/remote-control；v2.1.51+；已加入 routines.md |

## 未驗證 / 疑似幻覺（仍不確定）

- "AutoDream" — ❌ 確認幻覺，無任何官方來源
- 具體效能數字（"20%→50% skill activation"）— ⚠️ 社群文章推測，非官方，不引用
- Mobile `/teleport` — ❌ 確認幻覺；正確為 `/remote-control` + QR code

## 下次審計建議查詢詞

```
site:github.com/shanraisshan/claude-code-best-practice tips
site:x.com bcherny claude
site:x.com trq212 claude
site:x.com bcherny claude code
site:x.com trq212 claude code
howborisusesclaudecode.com
site:github.com bcherny claude
site:github.com trq212 claude
claude.com/blog
code.claude.com/docs/en/
thariq.io
```
