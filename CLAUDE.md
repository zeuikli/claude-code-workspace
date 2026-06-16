# CLAUDE.md

> 繁體中文優先 · English supported · Repo: <https://github.com/zeuikli/claude-code-workspace>

*本檔案約 560 token，每次 session 必載入。與 workspace 無關的任務考慮 `/clear` 節省 token。*

## 四層載入框架

```
🔴 Real-time  — session-init.sh hook + CLAUDE.md 本體
🟡 Auto       — 4 rules @-imported (core/subagent/context/output) ~3,600 tok
🟢 On-demand  — skills：說觸發詞才載入
⚪ Skip       — docs/ 參考文件：手動 Read 即可
```

> 💡 `/load-plan` 查看完整清單含 token 估算

---

## The Loop（行為契約 — 唯一準則）

> 改進 / 稽核 / 迭代任務走六階段 **OBSERVE → IDENTIFY → PROPOSE → APPLY → TEST → RECORD** + 跨切紀律。
> canonical 條文見 `.claude/rules/core.md`（已自動載入）。

- **IMPORTANT**: 改動完成 → `git add → commit → push -u origin <branch>`（失敗重試 4 次）。
- **IMPORTANT**: 實作前**先說出理解與假設**，不確定時說出來而非盲目推進。
- **IMPORTANT**: 研究 / 實作 / 測試任務**優先委派 Sub Agent**，主對話僅收摘要。

## 常駐規則（🟡 自動載入）

- @.claude/rules/core.md — The Loop 六階段 + 語言 / Git / 生產紅線
- @.claude/rules/subagent-strategy.md — 委派決策 / Fan-out / Advisor 模式
- @.claude/rules/context-management.md — Token 預算 / Compact / Prompt Caching
- @.claude/rules/output-discipline.md — 無開場白 / 填充語禁止 / 精簡輸出

## 按需載入（🟢 說觸發詞才載入）

> 💡 完整清單與 token 估算：執行 `/load-plan`

- **Workspace**：`/load-plan`、冷啟接手 codebase、session 回顧、context 效率
- **Opus 調校 / Tasks / 多 Agent**：Tasks 跨 session、Opus 4.8 subagent 平行化、工具使用引導
- **開發**：除錯測試失敗、效能分析、大型重構、commit 前審查、需求訪談
- **排程 / CLI**：排程 webhook routine、CLI 工具 ast-grep yq、新增 skill/agent
- **行銷 / 研究 / PM**：行銷策略文案 SEO、市場調查競品、Sprint PM 多 agent

## 進階文件（⚪ 手動 Read）

- `docs/INDEX.md` — 進階文件索引
- `.claude/REFERENCES.md` — 官方文件對照表
