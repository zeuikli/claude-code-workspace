# docs/ 文件索引

> 此目錄存放深度分析與設計文件，**不會自動載入**到 Claude context。
> 需要時透過 `Read /home/user/claude-code-workspace/docs/<file>.md` 主動讀取，避免占用 token 預算。
> 最後更新：2026-04-18（v3 — Tier 分層重組，歷史文件移入 archive/）

---

## Tier 1 — 必讀（核心架構）

| 文件 | 說明 | 最後驗證 |
|------|------|----------|
| [advisor-strategy.md](advisor-strategy.md) | Advisor 模式完整論述（Haiku 4.5 / Sonnet 4.6 / Opus 4.7 三層分工） | 2026-04-17 |
| [multi-agent-coordination.md](multi-agent-coordination.md) | 5 種多 agent 協調模式決策表（Generator-Verifier / Orchestrator-Subagent / Agent Teams / Message Bus / Shared State） | 2026-04-17 |
| [opus47-migration.md](opus47-migration.md) | Opus 4.6 → 4.7 完整遷移指引（settings diff / prompt 習慣 / 驗證清單 / FAQ） | 2026-04-17 |
| [tool-design-principles.md](tool-design-principles.md) | 工具設計心智模型（高門檻加工具 / Progressive Disclosure / 動作分類 / Subagent = 動作空間擴充） | 2026-04-17 |

---

## Tier 2 — 按需載入（效能 / 配置）

| 文件 | 說明 | 何時讀 |
|------|------|--------|
| [auto-memory-hybrid.md](auto-memory-hybrid.md) | 官方 Auto Memory vs 自製 Memory.md 對比與 Hybrid 採用指南 | 評估啟用 Auto Memory、跨機器同步策略 |
| [timeout-guide.md](timeout-guide.md) | Stream timeout 完整指南（整合自兩份原始調查報告，單一權威來源） | 遇到串流中斷、長 Bash 卡住、調整 timeout 設定前 |
| [hook-lifecycle.md](hook-lifecycle.md) | 10 個 Hook 腳本 + 7 種事件的 sequenceDiagram + 競態防護 + 除錯指南 | Hook 除錯、新人理解 hook 生命週期 |
| [prompt-caching-verification.md](prompt-caching-verification.md) | 驗證 cache hit 的方法與指標 | 評估 prompt caching 效益 |
| [prompts-advanced.md](prompts-advanced.md) | 進階提示模板集 | 撰寫複雜 prompt、啟動新 session |
| [workspace-performance-report.md](workspace-performance-report.md) | Workspace 效能基準（成本 -72.4%、平行加速 2.6-7.3×） | 評估優化效益、設定基準時 |
| [karpathy-optimization-report.md](karpathy-optimization-report.md) | Karpathy 風格 workspace 優化效益報告 | 評估 workspace 改進效益、設定基準 |
| [blog-analysis-report.md](blog-analysis-report.md) | 22 篇 Anthropic Blog 文章可操作洞察萃取 | 尋找 prompt engineering / agent 設計靈感 |
| [auto-mode-analysis.md](auto-mode-analysis.md) | Auto mode 行為分析 | 評估 auto mode 適用場景 |
| [mode-evaluation.md](mode-evaluation.md) | 各操作模式評估比較 | 選擇操作模式前 |

---

## Tier 3 — 歷史存檔（docs/archive/）

| 文件 | 說明 | 封存原因 |
|------|------|----------|
| [archive/session7-followup-report.md](archive/session7-followup-report.md) | Session 7 二次深度優化 follow-up 報告（16 項 todos） | 優化已完成，設計脈絡已沉澱至各現役文件 |
| [archive/perf-report-044b5cd-vs-a9ffc1d.md](archive/perf-report-044b5cd-vs-a9ffc1d.md) | commit 044b5cd vs a9ffc1d 效能比較報告 | 特定 commit 比較已過時，數據已整合至效能報告 |
| [codex-migration-guide.md](codex-migration-guide.md) | Codex 遷移指南 | 遷移指南為一次性參考，非日常按需 |
| [caveman-hooks-analysis.md](caveman-hooks-analysis.md) | Caveman hooks 原始分析 | 實驗性分析報告，已整合至 caveman skill |

> `stream-timeout-investigation.md` 與 `timeout-settings-impact-analysis.md` 已於 Session 7 合併至 `timeout-guide.md` 並刪除（非移入 archive）。

---

## 載入策略

| 場景 | 策略 |
|------|------|
| 一般任務 | 主 CLAUDE.md + `.claude/rules/` 即足夠 |
| 架構決策 | 主動讀取 `advisor-strategy.md` |
| 多 agent 協調設計 | 主動讀取 `multi-agent-coordination.md` |
| Prompt 設計研究 | 主動讀取 `blog-analysis-report.md` |
| 效能優化 | 主動讀取 `workspace-performance-report.md` |
| Hook / Timeout 除錯 | 主動讀取 `timeout-guide.md`（整合版本） |
| Opus 4.7 升級 | 主動讀取 `opus47-migration.md` |
| 新增 Skill / Agent / Tool | 主動讀取 `tool-design-principles.md` |

---

## 文件貢獻

新增 doc 時：
1. 在此 INDEX 加一行（檔名 + 說明 + 最後驗證日），置於合適的 Tier 下
2. doc 頂部加 `> tags: [...]` 或來源 URL 方便搜尋
3. **不要**在 CLAUDE.md / `.claude/rules/` 加 `@docs/...` 引用，避免破壞 lazy-load 設計
4. 整合型文件（如 `timeout-guide.md`）應在原始檔頂部標註已被整合，並保留供歷史追溯
