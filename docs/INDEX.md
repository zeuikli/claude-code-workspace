# 進階文件索引

> 此目錄存放深度分析與設計文件，**不會自動載入**到 Claude context。
> 需要時透過 `Read /tmp/claude-code-workspace/docs/<file>.md` 主動讀取，避免占用 token 預算。

| 檔案 | 主題 | 何時讀 |
|---|---|---|
| `advisor-strategy.md` | Advisor 模式完整論述（Haiku/Sonnet/Opus 三層分工） | 設計新 Sub Agent 工作流時 |
| `blog-analysis-report.md` | 22 篇 Anthropic Blog 文章可操作洞察萃取 | 尋找 prompt engineering / agent 設計靈感 |
| `workspace-performance-report.md` | Workspace 效能基準（成本 -72.4%、平行加速 2.6-7.3×） | 評估優化效益、設定基準時 |
| `timeout-guide.md` | Stream timeout 完整指南（根因 + 設定 + 影響矩陣 + 診斷 checklist） | 遇到串流中斷、長時間 Bash 卡住、調整 timeout 設定前 |
| `karpathy-optimization-report.md` | Karpathy 風格 workspace 優化效益報告 | 評估 workspace 改進效益、設定基準 |
| `hook-lifecycle.md` | 10 個 Hook 腳本 + 7 種事件的 sequenceDiagram + 競態防護 + 除錯指南 | Hook 除錯、新人理解 hook 生命週期 |
| `auto-memory-hybrid.md` | 官方 Auto Memory vs 自製 Memory.md 對比與 Hybrid 採用指南 | 評估啟用 Auto Memory、跨機器同步策略 |

## 載入策略

| 場景 | 策略 |
|---|---|
| 一般任務 | 主 CLAUDE.md + `.claude/rules/` 即足夠 |
| 架構決策 | 主動讀取 `advisor-strategy.md` |
| Prompt 設計研究 | 主動讀取 `blog-analysis-report.md` |
| 效能優化 | 主動讀取 `workspace-performance-report.md` |
| Hook / Timeout 除錯 | 主動讀取 `stream-timeout-investigation.md` |

## 文件貢獻

新增 doc 時：
1. 在此 INDEX 加一行（檔名 + 主題 + 何時讀）
2. doc 頂部加 `> tags: [...]` 方便搜尋
3. **不要**在 CLAUDE.md / `.claude/rules/` 加 `@docs/...` 引用，避免破壞 lazy-load 設計
