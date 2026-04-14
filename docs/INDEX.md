# 進階文件索引

> 此目錄存放深度分析與設計文件，**不會自動載入**到 Claude context。
> 需要時透過 `Read /tmp/claude-code-workspace/docs/<file>.md` 主動讀取，避免占用 token 預算。

| 檔案 | 主題 | 何時讀 |
|---|---|---|
| `advisor-strategy.md` | Advisor 模式完整論述（Haiku/Sonnet/Opus 三層分工） | 設計新 Sub Agent 工作流時 |
| `blog-analysis-report.md` | 22 篇 Anthropic Blog 文章可操作洞察萃取 | 尋找 prompt engineering / agent 設計靈感 |
| `workspace-performance-report.md` | Workspace 效能基準（成本 -72.4%、平行加速 2.6-7.3×） | 評估優化效益、設定基準時 |
| `stream-timeout-investigation.md` | Stream idle timeout 根本原因調查 | 遇到串流中斷、長時間 Bash 卡住時 |
| `timeout-settings-impact-analysis.md` | Timeout 環境變數影響分析 | 調整 `CLAUDE_STREAM_IDLE_TIMEOUT_MS` 等設定前 |

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
