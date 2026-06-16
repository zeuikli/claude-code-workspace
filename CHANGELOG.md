# CHANGELOG

所有重要變更皆記錄於此文件。

---

## 2026-06-16 — 導入 The Loop Harness：行為契約大改版

將 workspace 的指令規則重建為 **The Loop** 六階段行為契約，作為唯一行為準則。

### 核心變更

- **`.claude/rules/` 重建為 The Loop**：六階段元迴圈 **OBSERVE → IDENTIFY → PROPOSE → APPLY → TEST → RECORD** + 跨切紀律，分為四個常駐自動載入規則：
  - `core.md` — 六階段行為契約 + 語言 / Git / 生產紅線 / Effort
  - `subagent-strategy.md` — 委派決策 / Fan-out / Advisor 模式
  - `context-management.md` — Token 預算 / Compact / Prompt Caching
  - `output-discipline.md` — 無開場白 / 填充語禁止 / 精簡輸出
- **CLAUDE.md / README**：四層載入框架對齊新的 The Loop 規則集，token 估算以 `load-plan.sh` 為準。

### 文件與腳本整理

- **`docs/`**：精簡為索引（`INDEX.md`）+ 最佳實踐研究報告（`2026-05-16-claude-code-best-practices.md`）兩篇。
- **`scripts/`**：稽核並修正 `healthcheck.sh`（`cd` 失敗終止、Hook Coverage 空值警告）與 `load-plan.sh`（補列遺漏 skill、TIER 3 空集合提示、移除死碼）；通過 `shellcheck` 與端到端執行驗證。
