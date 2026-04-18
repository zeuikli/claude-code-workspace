# 進階文件索引

> 此目錄存放深度分析與設計文件，**不會自動載入**到 Claude context。
> 需要時透過 `Read /tmp/claude-code-workspace/docs/<file>.md` 主動讀取，避免占用 token 預算。
> 最後更新：2026-04-17（v2 — 同步 Opus 4.7 深化改動）

## 設計論述與官方對齊

| 檔案 | 主題 | 何時讀 |
|---|---|---|
| `advisor-strategy.md` | Advisor 模式完整論述（Haiku 4.5 / Sonnet 4.6 / Opus 4.7 三層分工 + `advisor_20260301` API） | 設計新 Sub Agent 工作流、評估是否升級顧問呼叫時 |
| `opus47-migration.md` | Opus 4.6 → 4.7 完整遷移指引（settings diff / prompt 習慣 / 驗證清單 / FAQ） | 從 4.6 升級、調整 effort 等級前 |
| `multi-agent-coordination.md` | **5 種多 agent 協調模式決策表**（Generator-Verifier / Orchestrator-Subagent / Agent Teams / Message Bus / Shared State） | 評估平行 subagent 架構、選擇協調模式前 |
| `tool-design-principles.md` | **工具設計心智模型**（Seeing like an agent — 高門檻加工具 / Progressive Disclosure / 動作分類 / Subagent = 動作空間擴充） | 新增 `.claude/agents/` 或 `.claude/skills/` 前，設計工具前 |
| `auto-memory-hybrid.md` | 官方 Auto Memory vs 自製 Memory.md 對比與 Hybrid 採用指南 | 評估啟用 Auto Memory、跨機器同步策略 |

## 效能與效益報告

| 檔案 | 主題 | 何時讀 |
|---|---|---|
| `workspace-performance-report.md` | Workspace 效能基準（成本 -72.4%、平行加速 2.6-7.3×） | 評估優化效益、設定基準時 |
| `karpathy-optimization-report.md` | Karpathy 風格 workspace 優化效益報告 | 評估 workspace 改進效益、設定基準 |
| `session7-followup-report.md` | Session 7 二次深度優化 follow-up 報告（16 項 todos） | 回顧 P0/P1 優化決策、追溯設計脈絡 |
| `blog-analysis-report.md` | 22 篇 Anthropic Blog 文章可操作洞察萃取 | 尋找 prompt engineering / agent 設計靈感 |

## 工程與除錯

| 檔案 | 主題 | 何時讀 |
|---|---|---|
| `timeout-guide.md` | **Stream timeout 完整指南**（整合自 stream-timeout-investigation + timeout-settings-impact-analysis） | 遇到串流中斷、長 Bash 卡住、調整 timeout 設定前 |
| `stream-timeout-investigation.md` | 原始調查報告（已整合進 timeout-guide.md，保留供歷史追溯） | 僅歷史追溯用；日常除錯請讀 timeout-guide.md |
| `timeout-settings-impact-analysis.md` | 原始影響分析報告（已整合進 timeout-guide.md，保留供歷史追溯） | 僅歷史追溯用；日常除錯請讀 timeout-guide.md |
| `hook-lifecycle.md` | 10 個 Hook 腳本 + 7 種事件的 sequenceDiagram + 競態防護 + 除錯指南 | Hook 除錯、新人理解 hook 生命週期 |

## 載入策略

| 場景 | 策略 |
|---|---|
| 一般任務 | 主 CLAUDE.md + `.claude/rules/` 即足夠 |
| 架構決策 | 主動讀取 `advisor-strategy.md` |
| 多 agent 協調設計 | 主動讀取 `multi-agent-coordination.md` |
| Prompt 設計研究 | 主動讀取 `blog-analysis-report.md` |
| 效能優化 | 主動讀取 `workspace-performance-report.md` |
| Hook / Timeout 除錯 | 主動讀取 `timeout-guide.md`（整合版本） |
| Opus 4.7 升級 | 主動讀取 `opus47-migration.md` |
| 新增 Skill / Agent / Tool | 主動讀取 `tool-design-principles.md` |

## 文件貢獻

新增 doc 時：
1. 在此 INDEX 加一行（檔名 + 主題 + 何時讀），置於合適的分類下
2. doc 頂部加 `> tags: [...]` 或來源 URL 方便搜尋
3. **不要**在 CLAUDE.md / `.claude/rules/` 加 `@docs/...` 引用，避免破壞 lazy-load 設計
4. 整合型文件（如 `timeout-guide.md`）應在原始檔頂部標註已被整合，並保留供歷史追溯
