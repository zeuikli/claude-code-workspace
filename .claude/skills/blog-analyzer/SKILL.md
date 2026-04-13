---
name: blog-analyzer
description: 分析 claude.com/blog 的新文章，提取可操作洞察並更新 workspace 設定。手動調用。
disable-model-invocation: true
---

# Blog Analyzer — 分析 Claude 官方文章

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
