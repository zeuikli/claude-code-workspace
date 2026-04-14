---
name: blog-analyzer
description: 分析 claude.com/blog 的新文章，提取可操作洞察並更新 workspace 設定。手動調用。
when_to_use: 使用者提供 URL 或文章路徑要求分析、整合洞察到 workspace 時。也適用於每月定期巡檢新發布的 Anthropic 內容。
disable-model-invocation: true
allowed-tools: Read, Write, WebFetch, WebSearch
model: sonnet
effort: medium
---

# Blog Analyzer — 分析 Claude 官方文章

> **Ref**:
> - Claude Blog 首頁: https://claude.com/blog
> - Skills frontmatter: https://code.claude.com/docs/en/skills
> - 完整對照: `.claude/REFERENCES.md`

## 何時觸發

- 使用者提供 claude.com/blog 文章 URL
- 使用者要求「分析這篇文章、看能不能用」
- 月底 / 季初定期巡檢新內容
- 注意：本 Skill 為手動觸發（`disable-model-invocation: true`）

## 預期輸出

- 文章分類 + 實用度評分（⭐⭐⭐⭐⭐）
- 1 句核心洞察摘要
- 可實作的具體行動清單（不直接修改檔案）
- 自動 append 到 `docs/blog-analysis-report.md`

## 使用範例

```
使用者：請用 blog-analyzer 分析 https://claude.com/blog/multi-agent-coordination-patterns
→ Skill 觸發 WebFetch
→ 分類為 agent-architecture
→ 提取 3 個可操作洞察
→ 產出建議行動：「新增 agent-team Skill」「更新 CLAUDE.md 加入平行規則」
→ 結果 append 到 docs/blog-analysis-report.md
```

分析 $ARGUMENTS 指定的文章（URL 或 blog-archive 中的檔案路徑）。

## 步驟

1. **讀取文章**：如果是 URL，使用 WebFetch 抓取；如果是檔案路徑，直接讀取
2. **分類**：將文章歸類為 agent-architecture / claude-code-features / api-platform / security / case-study / industry-insight
3. **提取洞察**：
   - 可操作的技術建議（能直接應用的）
   - 可實作的模式或配置
   - 成本 / 效能 / 品質的量化數據
4. **評估影響**：判斷是否需要更新以下檔案：
   - `.claude/agents/` — 新增或修改 Agent 定義
   - `.claude/skills/` — 新增或修改 Skill
   - `CLAUDE.md` — 新增規則
   - `docs/advisor-strategy.md` — 更新策略
5. **產出建議**：列出具體的變更建議，不直接修改
6. **更新報告**：將分析結果附加到 `docs/blog-analysis-report.md`

## 輸出格式

```markdown
### [文章標題]
- **分類**：xxx
- **實用度**：⭐⭐⭐⭐⭐
- **核心洞察**：一句話摘要
- **建議行動**：
  - [ ] 具體行動 1
  - [ ] 具體行動 2
```
