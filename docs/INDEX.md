# 進階文件索引

> 此目錄存放深度分析與參考文件，**不會自動載入**到 Claude context。
> 需要時透過 `Read docs/<file>.md` 主動讀取，避免占用 token 預算。

## 研究報告

| 檔案 | 主題 | 何時讀 |
|---|---|---|
| `2026-05-16-claude-code-best-practices.md` | **Claude Code 各面向最佳實踐完整報告**（CLAUDE.md 設計、Hooks 架構、Prompt Caching、Subagent 委派、Skill 封裝、MCP 整合、安全部署、成本工程） | 全面了解 Claude Code 最佳實踐、建立新 workspace、進行系統改進評估時 |

## 載入策略

| 場景 | 策略 |
|---|---|
| 一般任務 | 主 CLAUDE.md + `.claude/rules/`（The Loop 六階段）即足夠 |
| 查看所有可用工具 | `/load-plan` 指令（動態顯示） |
| 全面了解 Claude Code 最佳實踐 | 主動讀取 `2026-05-16-claude-code-best-practices.md` |

## 文件貢獻

新增 doc 時：
1. 在此 INDEX 加一行（檔名 + 主題 + 何時讀）
2. doc 頂部加來源 URL 方便搜尋
3. **不要**在 CLAUDE.md / `.claude/rules/` 加 `@docs/...` 引用，避免破壞 lazy-load 設計
