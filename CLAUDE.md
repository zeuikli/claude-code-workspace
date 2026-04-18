# CLAUDE.md

> 繁體中文優先 · English supported · Repo: <https://github.com/zeuikli/claude-code-workspace>

*本檔案約 430 token，每次 session 必載入。與 workspace 無關的任務考慮 `/clear` 節省 token。*

## 四層載入框架

```
🔴 Real-time  — session-init.sh hook + CLAUDE.md 本體
🟡 Auto       — 3 rules @-imported (core/subagent/context) ~1,700 tok
🟢 On-demand  — 16 skills + 6 rules：說觸發詞才載入
⚪ Skip       — docs/archive, reference docs：手動 Read 即可
```

> 💡 `/load-plan` 查看完整清單含 token 估算

---

## 核心規則

- 改動完成：`git add → commit → push -u origin <branch>`（失敗重試 4 次）
- 實作前：先說出理解與假設，不確定時說出來而非盲目推進
- 任務分工：研究 / 實作 / 測試優先委派 Sub Agent，主對話僅收摘要

## 常駐規則（🟡 自動載入，約 1,700 tok）

- @.claude/rules/core.md
- @.claude/rules/subagent-strategy.md
- @.claude/rules/context-management.md

## 按需載入（🟢 說觸發詞才載入）

> 💡 完整清單與 token 估算：執行 `/load-plan`

- **Workspace**：`/load-plan`、冷啟接手 codebase、session 回顧、context 效率
- **開發**：除錯測試失敗、效能分析、大型重構、commit 前審查、需求訪談
- **排程 / CLI**：排程 webhook routine、CLI 工具 ast-grep yq、新增 skill/agent
- **行銷 / 研究 / PM**：行銷策略文案 SEO、市場調查競品、Sprint PM 多 agent

## 進階文件（⚪ 手動 Read）

- `docs/INDEX.md` — 文件總索引
- `.claude/REFERENCES.md` — 官方文件對照表
