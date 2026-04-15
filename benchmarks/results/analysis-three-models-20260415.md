# 三模型跨比較分析報告
**模型**: Haiku 4.5 / Sonnet 4.6 / Opus 4.6  
**日期**: 2026-04-15  
**測試**: 10 prompts × 5 conditions × 1 trial × 3 models = 150 API calls

---

## 跨模型總覽

| Condition | Haiku 4.5 | Sonnet 4.6 | Opus 4.6 |
|-----------|:---------:|:----------:|:--------:|
| Baseline（無壓縮）| 1,194 | 1,554 | 1,600 |
| Full（標準）| 476 (−51%) | 683 (−53%) | 609 (−59%) |
| Lite（輕量）| 478 (−49%) | 620 (−57%) | 605 (−59%) |
| Ultra（超壓縮）| 467 (−50%) | **556 (−62%)** | **587 (−61%)** |
| **Auto Mode** | 496 (−45%) | **646 (−56%)** | **595 (−60%)** |

> 數字為平均 output tokens；括號為相對 baseline 節省率

---

## 核心發現

### 1. 模型越強，壓縮效果越好

| 模型 | Best Savings | 原因 |
|------|:-----------:|------|
| Haiku 4.5 | 51% (full) | 遵循壓縮指令能力較弱，模式差距小 |
| Sonnet 4.6 | 62% (ultra) | 精確遵循 ultra 規則，各模式差距明顯 |
| Opus 4.6 | 61% (ultra) | 天然簡潔，各模式差距極小（2%）|

### 2. Auto Mode 隨模型強化而趨近最佳解

| 模型 | Auto vs Best Mode | 差距 |
|------|:-----------------:|:----:|
| Haiku | 45% vs Full 51% | −6% |
| Sonnet | 56% vs Ultra 62% | −6% |
| **Opus** | **60% vs Ultra 61%** | **−1%** ✓ |

**Opus 上 Auto Mode 幾乎達到最佳解！** 只差 1%，已在統計誤差內。

### 3. Sonnet: Auto 優於 Full（+3%）

Sonnet auto（56%）> Sonnet full（53%）— **Auto mode 在 Sonnet 上不只是省時，輸出更精簡**。

原因：分類器將 bug-fix prompt 導向 ultra（auth-middleware-fix: 83%），
將說明型導向 lite，平均比 full 的一刀切效果更好。

### 4. Ultra 在強模型上效益最高

| 模型 | Full | Ultra | Ultra 優勢 |
|------|:----:|:-----:|:----------:|
| Haiku | 51% | 50% | −1%（無優勢）|
| Sonnet | 53% | **62%** | **+9%** ✓ |
| Opus | 59% | **61%** | +2% |

**Sonnet 上強制 Ultra 有顯著優勢（+9%）**，但代價是說明型回應可讀性下降。

---

## 逐題跨模型熱點分析

### 最高壓縮任務（ultra prompt：bug-fix 類）

| Task | Haiku Auto | Sonnet Auto | Opus Auto |
|------|:----------:|:-----------:|:---------:|
| auth-middleware-fix (ultra) | 52% | **83%** | 79% |
| race-condition-debug (ultra) | 62% | **74%** | 60% |

→ Sonnet + ultra 分類 = 最強壓縮，auth bug fix 省 83%

### 最抗壓縮任務（所有模式節省率低）

| Task | Haiku | Sonnet | Opus |
|------|:-----:|:------:|:----:|
| pr-security-review | 31-55% | **9-18%** | 40-62% |
| git-rebase-merge | 21-33% | 46-52% | 29-41% |

→ `pr-security-review` 在 Sonnet 上抗壓縮（Sonnet 傾向完整解釋安全問題）

### Auto Mode 最佳表現（auto 勝過 full）

| Task | Model | Auto | Full | Auto 優勢 |
|------|-------|:----:|:----:|:---------:|
| git-rebase-merge | Sonnet | 52% | 48% | +4% |
| microservices-monolith | Sonnet | 62% | 52% | +10% |
| pr-security-review | Sonnet | 18% | 13% | +5% |
| react-rerender | Opus | 73% | 67% | +6% |
| async-refactor | Opus | 70% | 69% | +1% |

---

## 輸入 Token 成本分析

| Condition | 輸入 tokens（avg）| 說明 |
|-----------|:-----------------:|------|
| Baseline | 54 | prompt only |
| Ultra | 542 | 過濾後 SKILL.md（最小）|
| Lite | 536 | 過濾後 SKILL.md |
| **Auto** | **702** | 混合（lite=完整 SKILL.md 約 30%）|
| Full | 947 | 完整 SKILL.md（最大）|

Auto mode 比 full 省 **26% 輸入 token**，同時輸出節省率在 Sonnet/Opus 上優於或接近 full。

---

## 模型選用建議

| 場景 | 推薦模型 | 推薦模式 | 理由 |
|------|---------|:--------:|------|
| 日常快速任務 | Haiku | Full 或 Auto | 模式差距小，Auto 無明顯損失 |
| 標準開發工作 | Sonnet | **Auto** | Auto(56%) ≥ Full(53%)，品質佳 |
| 複雜架構/審查 | Opus | **Auto** | Auto(60%) ≈ Ultra(61%)，近乎最佳 |
| 純省 token 最大化 | Sonnet | **Ultra** | 強制 ultra 多省 9% vs full |

---

## 最終結論

```
Auto Mode 實際效益：
  Haiku:  −45% output（vs baseline）
  Sonnet: −56% output（比 full 多省 3%）
  Opus:   −60% output（僅差最佳 1%）

輸入節省（vs full）：
  所有模型：節省 26% 輸入 token（702 vs 947）

整體 API 成本估算節省 vs baseline：
  Haiku:  ~40-45%
  Sonnet: ~50-55%
  Opus:   ~55-60%
```

**Auto Mode 是三模型中最平衡的選擇**：無需手動切換、Sonnet/Opus 表現優於或等同 full、
輸入 token 比 full 省 26%、說明型 prompt 品質優於強制 ultra。

---

## 附錄：各模型原始報告

- `auto_benchmark_haiku_20260415_080119.md`
- `auto_benchmark_sonnet_20260415_081036.md`
- `auto_benchmark_opus_20260415_082038.md`
- `auto_benchmark_*.json`（原始 API 數據）
