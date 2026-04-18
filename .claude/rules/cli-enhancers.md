---
description: CLI 增強工具目錄 — ast-grep / sd / yq / delta / hyperfine 等
tier: ondemand
---

# CLI 增強工具目錄

> 按需載入：需要高效 code 搜尋、結構比對、效能分析時。

## 工具清單

| 工具 | 用途 | 適用場景 |
|------|------|---------|
| `ast-grep` | AST 結構搜尋與重構 | 跨語言結構模式搜尋（比 regex 精確，不受格式影響） |
| `shellcheck` | Shell script lint | 撰寫或審查 `.sh` 檔案；CI 必用，避免隱藏 bug |
| `sd` | sed 替代（PCRE regex） | 批次文字替換，無需逃脫特殊字元 |
| `scc` | 程式碼統計（行數/複雜度） | 快速摸清 codebase 規模，找出高複雜度檔案 |
| `yq` | YAML/JSON/TOML 查詢與修改 | 編輯 settings.json / CI YAML 時保留原始格式 |
| `hyperfine` | CLI 效能基準測試 | 比較兩個命令的執行速度，量化優化效果 |
| `delta` | syntax-highlighted git diff | 替代預設 `git diff`，可讀性大幅提升 |
| `difft` | AST 結構 diff | 重構時確認只有語意不變的改動（非行差異） |
| `watchexec` | 檔案變更時自動執行命令 | 開發時即時 lint/test，省去手動觸發 |
| `comby` | 跨語言結構搜尋替換 | 大規模重構時替換特定程式碼模式 |

## 使用前提

這些工具**可能未預裝**。使用前先確認：

```bash
which ast-grep shellcheck sd scc yq hyperfine delta difft watchexec
```

若缺少，改用內建工具替代：
- `ast-grep` → `Grep` tool（regex 模式）
- `shellcheck` → Claude 直接審查
- `sd` → `Edit` tool
- `delta` / `difft` → `git diff`（預設）

## 優先順序

直接工具（Grep / Read / Glob）> CLI enhancers > Task agents

只有在內建工具無法滿足需求時，才呼叫 CLI enhancers。
