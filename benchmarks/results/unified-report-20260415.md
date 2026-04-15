# Caveman Hooks 效能測試統一報告

> 測試日期：2026-04-15  
> 環境：Claude Code Web（雲端）/ Claude Code Desktop（地端）
> Branch: claude/caveman-hooks-integration-8rFJO

---

## 測試總覽

| 測試類型 | 執行環境 | 工具 | 目的 |
|---------|--------|------|------|
| 靜態 Input 分析 | 地端（tiktoken）| `benchmark-injection-modes.py` | 量測注入開銷（無 API）|
| API Output 測試 | 雲端（Anthropic API）| `run-auto-benchmark.py` | 量測壓縮效果（真實 API）|

---

## Part 1：地端靜態分析 — 注入 Token 開銷

> 工具：tiktoken cl100k_base（本地估算，無 API 費用）  
> 測試日期：2026-04-15 07:22

### 三種注入模式 Input Token 比較

| 模式 | 說明 | Input Tokens | vs Mode A |
|------|------|:------------:|:---------:|
| **A** CLAUDE.md 全量 | `@file` 引用全部 rules/*.md | 2,546 | 基準 |
| **B** SKILL.md Hook | SessionStart hook 注入壓縮版 | 306 | **−88%** |
| **C** Rules.md 最小 | 僅注入最小核心規則 | 109 | **−96%** |

### Rules 檔案貢獻分解（Mode A）

| 檔案 | Tokens | 佔比 |
|------|:------:|:---:|
| subagent-strategy.md | 903 | 35% |
| CLAUDE.md | 574 | 23% |
| auto-sync.md | 317 | 12% |
| git-workflow.md | 252 | 10% |
| context-management.md | 227 | 9% |
| quality.md | 183 | 7% |
| language.md | 80 | 3% |

### 百次 Session 累積成本估算

| 模式 | 100 sessions Input Tokens |
|------|:------------------------:|
| A（CLAUDE.md 全量）| **254,600** |
| B（SKILL.md Hook）| 30,600 |
| C（Rules.md 最小）| 10,900 |

> **結論**：地端分析確認 Hook 注入（Mode B）比傳統 CLAUDE.md 節省 88% 輸入 token。

---

## Part 2：雲端 API 測試 — 輸出壓縮效果

> 工具：Anthropic API 直呼叫  
> 測試日期：2026-04-15 08:06–08:34  
> 總計：150 API calls（50 per model × 3 models）

### 2-1. 三模型輸出節省率總覽

| Condition | Haiku 4.5 | Sonnet 4.6 | Opus 4.6 | 三模型均值 |
|-----------|:---------:|:----------:|:--------:|:--------:|
| Baseline（無壓縮）| 1,194 tokens | 1,554 tokens | 1,600 tokens | 1,449 |
| Full（標準壓縮）| 476 (−51%) | 683 (−53%) | 609 (−59%) | −54% |
| Lite（輕量壓縮）| 478 (−49%) | 620 (−57%) | 605 (−59%) | −55% |
| Ultra（超壓縮）| 467 (−50%) | **556 (−62%)** | 587 (−61%) | **−58%** |
| **Auto Mode** | 496 (−45%) | **646 (−56%)** | **595 (−60%)** | **−54%** |

### 2-2. Auto Mode 分類分布（三模型相同）

| Level | Count | % | 對應 prompt 類型 |
|-------|:-----:|:-:|----------------|
| lite | 4 | 40% | 說明/教學/架構類 |
| full | 4 | 40% | 實作/重構/部署類 |
| ultra | 2 | 20% | 除錯/bug fix 類 |

### 2-3. Auto Mode vs 最佳手動模式差距

| 模型 | Auto | 最佳手動 | 差距 | 評估 |
|------|:----:|:-------:|:----:|------|
| Haiku 4.5 | −45% | Full −51% | **−6%** | 可接受 |
| Sonnet 4.6 | −56% | Ultra −62% | **−6%** | Auto > Full (+3%) ✓ |
| **Opus 4.6** | **−60%** | Ultra −61% | **−1%** | **近乎最佳** ✓✓ |

---

## Part 3：地端 vs 雲端執行差異

### Hook 執行環境

| 項目 | 地端（Desktop/Local）| 雲端（Web/Claude.ai）|
|------|---------------------|---------------------|
| Session-init 時間 | ~200–400ms（本地 git）| **598ms**（fetch+shallow）|
| Workspace 路徑 | `~/claude-code-workspace/` | `/tmp/claude-code-workspace/` |
| Hook 執行 | 本地 Node.js | 容器內 Node.js |
| API Key 設定 | `~/.env.local` 或 env | `.env.local` 在 project dir |
| Auto-classifier 延遲 | < 5ms（純 regex）| < 5ms（同）|
| StatusLine 顯示 | 完整支援 | 支援（web status bar）|

### 注入效果差異

兩個環境注入效果**相同**：
- `caveman-activate.js`（SessionStart）注入相同 SKILL.md 內容
- `caveman-auto-classifier.js`（UserPromptSubmit）執行相同分類邏輯
- API 測試結果（output tokens）不受執行環境影響

---

## Part 4：綜合效能指標

### 輸入 + 輸出綜合節省估算

以 Sonnet 4.6 + Auto Mode 為例，每 100 次 prompt：

| 項目 | Mode A CLAUDE.md | Mode B+Auto（現行）| 節省 |
|------|:----------------:|:-----------------:|:----:|
| Input tokens（注入）| 254,600 | 30,600（SKILL）+ 70,200（auto avg）= 100,800 | **−60%** |
| Output tokens | 155,400（baseline）| 64,600（auto −56%）| **−58%** |
| **綜合 token 總計** | **410,000** | **165,400** | **−60%** |

> 以 Sonnet 定價（$3/MTok in, $15/MTok out）估算：  
> Mode A：≈ $3.10/100 sessions  
> Mode B+Auto：≈ $1.27/100 sessions  
> **節省約 59%**

---

## Part 5：結論與建議

### 最終建議矩陣

| 執行環境 | 使用模型 | 建議模式 | 預期節省 |
|---------|--------|:-------:|:-------:|
| 地端 Desktop | Haiku | Full | −51% output |
| 地端 Desktop | Sonnet | **Auto** | −56% output + −60% input |
| 地端 Desktop | Opus | **Auto** | −60% output（近最佳）|
| 雲端 Web | Haiku | Full | −51% output |
| 雲端 Web | Sonnet | **Auto** | −56% output |
| 雲端 Web | Opus | **Auto** | −60% output |

### 現行 Workspace 設定確認

```json
// .claude/settings.json（已部署）
"env": { "CAVEMAN_AUTO_MODE": "true" }   // ✓ auto 啟用
"SessionStart": [caveman-activate.js]     // ✓ base rules 注入
"UserPromptSubmit": [caveman-auto-classifier.js]  // ✓ 每 prompt 自動分類
"statusLine": caveman-statusline.sh       // ✓ 即時顯示等級
```

### 各模式最終評分

| 模式 | 節省效率 | 品質 | 設定複雜度 | 推薦度 |
|------|:-------:|:----:|:--------:|:------:|
| CLAUDE.md 全量（Mode A）| ★☆☆☆☆ | ★★★★★ | ★★★★★ | 偶用 |
| SKILL.md Full Hook | ★★★☆☆ | ★★★★☆ | ★★★★☆ | 良好 |
| Forced Ultra | ★★★★★ | ★★★☆☆ | ★★★★☆ | Sonnet 特用 |
| **Auto Mode**（當前）| ★★★★☆ | ★★★★★ | ★★★☆☆ | **最推薦** |

---

## 附錄：所有原始測試文件

| 文件 | 類型 | 說明 |
|------|------|------|
| `results/injection_modes_static_20260415_072202.json` | 地端靜態分析 | Input token 測量（tiktoken）|
| `results/auto_benchmark_haiku_*.md` | 雲端 API 測試 | Haiku 50 calls |
| `results/auto_benchmark_sonnet_*.md` | 雲端 API 測試 | Sonnet 50 calls |
| `results/auto_benchmark_opus_*.md` | 雲端 API 測試 | Opus 50 calls |
| `results/analysis-haiku-20260415.md` | 單模型深度分析 | Haiku 詳細解析 |
| `results/analysis-three-models-20260415.md` | 跨模型比較 | 三模型比較分析 |
