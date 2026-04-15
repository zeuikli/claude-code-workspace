# 規則注入模式評估報告

> 分析 CLAUDE.md / SKILLS.md / Rules.md 三種模式的 token 效益與效率
> Repo: https://github.com/zeuikli/claude-code-workspace
> 參考: https://github.com/JuliusBrussee/caveman (standalone hooks)

---

## 架構概覽

本 Workspace 採用雙層 Hook 注入設計：

```
SessionStart
  ├─ session-init.sh           → 同步 workspace repo（git fetch）
  ├─ caveman-workspace-activate.js → 注入 workspace 操作規則
  └─ caveman-activate.js       → 注入 caveman 壓縮模式（NEW）

UserPromptSubmit
  ├─ user-prompt-submit.sh     → sub-agent 委派提醒
  └─ caveman-mode-tracker.js   → 追蹤 /caveman lite|ultra 指令（NEW）

StatusLine
  └─ caveman-statusline.sh     → 顯示 [CAVEMAN] / [CAVEMAN:ULTRA] 徽章（NEW）
```

---

## 三種模式比較

### Mode A — CLAUDE.md（傳統 @file 引用）

**機制**：`~/.claude/CLAUDE.md` 引用 `@workspace/CLAUDE.md`，再 `@rules/*.md`

| 指標 | 數值 |
|------|------|
| CLAUDE.md 大小 | 1,516 bytes |
| rules/*.md 合計 | 4,859 bytes |
| **總輸入開銷** | **~6,375 bytes ≈ 1,600 tokens/session** |
| 注入方式 | 每次 session 全部載入 |
| 壓縮率 vs A | 基準（0%）|

**優點**：
- 零基礎設施需求，純文件
- 版控清晰，git diff 一目了然
- 所有 AI agent（Cursor/Windsurf/Cline）共用同一份

**缺點**：
- 每次 session 都載入全部規則，即使大多數不相關
- 無法動態切換模式
- `@file` 引用在雲端 session 需要 git fetch 才能更新

---

### Mode B — SKILLS.md（Hook SessionStart 注入）

**機制**：`caveman-workspace-activate.js` 讀取 `skills/workspace-rules/SKILL.md`，以 SessionStart stdout 隱式注入

| 指標 | 數值 |
|------|------|
| SKILL.md 大小 | 1,411 bytes |
| **總輸入開銷** | **~1,411 bytes ≈ 353 tokens/session** |
| vs Mode A | **節省 ~78%** |
| 注入方式 | SessionStart hidden stdout |
| 使用者可見 | 否（完全透明） |

**優點**：
- 比 Mode A 節省約 78% 輸入 token
- 使用者看不見注入內容，不佔對話空間
- 支援 `full / selective / off` 三段控制
- 壓縮版本，語義完整

**缺點**：
- 需要 Node.js hook 基礎設施
- SKILL.md 修改後需測試 hook 執行

---

### Mode C — caveman SKILL.md（壓縮模式 + 輸出節省）

**機制**：`caveman-activate.js` 注入 caveman SKILL.md，**同時影響 AI 的輸出格式**

| 指標 | 數值（估算）|
|------|------|
| SKILL.md 大小（過濾後）| ~800 bytes（已過濾掉非 active level 的行）|
| **注入開銷** | **~200 tokens/session** |
| **輸出節省** | **~65-75%（來自 caveman 壓縮行為）** |
| 模式切換 | `/caveman lite` / `/caveman ultra` / `stop caveman` |
| StatusLine 徽章 | `[CAVEMAN]` / `[CAVEMAN:ULTRA]` |

**優點**：
- **雙重節省**：注入 token 少 + 輸出 token 也大幅減少
- 動態模式：lite（輕度）/ full（標準）/ ultra（極致壓縮）/ wenyan（文言文）
- StatusLine 即時顯示當前模式
- 與 workspace-rules 分層（兩者可並存）

**缺點**：
- 壓縮輸出對某些非技術對話可能不適用
- 需要 Auto-Clarity 機制來處理安全警告等特殊場景

---

## 綜合評分

| 指標 | Mode A (CLAUDE.md) | Mode B (SKILLS) | Mode C (caveman) |
|------|:------------------:|:---------------:|:----------------:|
| 設定複雜度 | ⭐⭐⭐⭐⭐ 最簡單 | ⭐⭐⭐ 需要 hooks | ⭐⭐⭐ 需要 hooks |
| 輸入 token 節省 | 0%（基準）| ~78% | ~88% |
| 輸出 token 節省 | 0% | 0% | ~65-75% |
| **總體效率** | 最低 | 中等 | **最高** |
| 可讀性 | 正常 | 正常 | 較壓縮 |
| 動態切換 | 否 | 部分（inject mode）| 是（5+ levels）|
| 雲端相容 | 需 session-init.sh | 是 | 是 |
| 推薦場景 | 偶發性使用 | 標準工作 | 高頻/長 session |

---

## 本 Workspace 採用方案

**雙層並行**（Mode B + Mode C 同時啟用）：

```
Layer 1: workspace-rules SKILL.md (Mode B)
  → 注入語言規則、sub-agent 策略、git 工作流
  → 每次 session 固定 ~353 tokens

Layer 2: caveman SKILL.md (Mode C)
  → 壓縮 AI 輸出，節省 output tokens
  → 支援 /caveman ultra 超壓縮模式
  → 注入 ~200 tokens，但輸出節省 65-75%

合計輸入開銷：~553 tokens（vs Mode A 的 ~1,600 tokens）
```

**淨效益**：
- 輸入 token：節省 **~65%**
- 輸出 token：節省 **~65-75%（啟用 caveman 時）**
- 整體 API 成本預估節省：**~65-72%**

---

## Benchmark 執行方式

```bash
# 快速測試（dry run，不打 API）
python3 benchmarks/run.py --dry-run

# 互動輸入 API Key
python3 benchmarks/run.py --trials 1 --model claude-haiku-4-5-20251001

# 只測特定模式
python3 benchmarks/run.py --mode B --trials 1

# 完整測試（需費用）
python3 benchmarks/run.py --trials 3
```

結果存放於 `benchmarks/results/benchmark_<timestamp>.json` 和 `.md`。

---

## 參考資料

- [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) — Standalone hooks 原始設計
- [Caveman benchmarks](https://github.com/JuliusBrussee/caveman/tree/main/benchmarks) — token 節省實測數據
- [Caveman evals](https://github.com/JuliusBrussee/caveman/tree/main/evals) — 三臂評估框架
- [Claude Code Hooks](https://docs.anthropic.com/en/docs/claude-code/hooks) — SessionStart/UserPromptSubmit 文件
