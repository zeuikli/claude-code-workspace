# Memory.md

> **預設空白** — 跨對話記憶由官方 Auto Memory 管理（`autoMemoryEnabled: true`，見 `/memory` 指令）。
> 此檔僅作相容性佔位，不進入 CLAUDE.md @import 鏈，不計入啟動成本。

---

## 近期關鍵決策（2026-06-01）

- **docs/ 盤點精簡**：刪除 `docs/archive/`（7 檔）+ `opus47-migration.md` + `best-practices-research-2026-04-18.md`，保留 12 個接活躍機制或 INDEX 知識庫的 docs。
- **Opus 4.8 對齊**（官方來源：`platform.claude.com/.../whats-new-claude-4-8`）：
  - **Advisor 模型升級** `claude-opus-4-7` → `claude-opus-4-8`（`settings.json` `advisorModel`）。
  - **重要更正**：Opus effort **預設為 `high`**（非 xhigh）；編碼/agentic 需**顯式設 `xhigh``。
  - `opus47-best-practices.md` → 改名 **`opus-best-practices.md`**（版本中性）。
  - 新增 4.8 要點：mid-conversation system messages（保 prompt cache）、fast mode、cache 門檻降至 1,024 token、tool triggering 改善。
  - cost-tracker 定價更正為官方 Opus 4.8 $5/$25。
