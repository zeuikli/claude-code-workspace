# Auto-Mode 自動壓縮等級分析報告

> 分析 `caveman-auto-classifier.js` 的設計、測試結果與效能預測
> 實作日期：2026-04-15

---

## 核心機制

### 問題背景

原始 caveman 系統要求使用者手動輸入 `/caveman ultra` 或 `/caveman lite`，造成使用摩擦。大多數使用者會停留在 `full` 模式，錯失進一步節省機會。

### 解決方案：UserPromptSubmit additionalContext

Claude Code 的 `UserPromptSubmit` hook 支援輸出 `hookSpecificOutput.additionalContext`，
這段文字會以**隱藏系統 context** 注入到當前 prompt 的處理中。

```
使用者送出 prompt
       ↓
caveman-auto-classifier.js (UserPromptSubmit hook)
       ↓
  分析 prompt → 判斷等級
       ↓
輸出 JSON:
{ "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "CAVEMAN AUTO: level=ultra. ..." }}
       ↓
Claude 看到隱藏指令 → 使用對應壓縮等級回應
       ↓
使用者看到壓縮後的回應
```

### 無需使用者介入

- Session start → 注入 base caveman rules（full 模式）
- 每個 prompt → auto-classifier 自動分析 → 動態覆寫等級
- StatusLine 即時顯示 `[CAVEMAN:AUTO:ULTRA]` / `[CAVEMAN:AUTO:LITE]`

---

## 分類器設計

### 優先級規則（順序重要）

```
Priority 1: 安全/破壞性操作  → lite（確保清晰完整說明）
Priority 1.5: fix/debug 型 how-do → ultra（修 bug ≠ 學習）
Priority 2: 教學/說明/架構型    → lite
Priority 2.5: 實作/重構型       → full（需要完整回應）
Priority 3: 短指令/Q&A/除錯型   → ultra
Priority 4: 預設               → full
```

### 等級定義對應

| 分類等級 | 對應 prompt 類型 | Caveman 行為 |
|----------|----------------|-------------|
| **ultra** | 短指令、除錯、Q&A | 縮寫、箭頭符號、一字即可 |
| **lite**  | 說明、教學、架構 | 保留完整句子、去除填充詞 |
| **full**  | 實作、重構、混合 | 標準 caveman（session 預設）|

### 分類器準確率測試

**測試集（23 題）準確率：91%（21/23）**

| 類型 | 準確率 | 備註 |
|------|:------:|------|
| Ultra 類 | 85% | 調試型 "why does" 歸 lite 為安全選擇 |
| Lite 類  | 100% | 教學/說明型全部正確 |
| Full 類  | 100% | 實作/重構型全部正確 |
| 安全覆寫 | 100% | 破壞性操作全部 → lite |

### benchmark 提示詞分類預測

| Prompt | 分類結果 | 推理 |
|--------|:--------:|------|
| React re-rendering (why?) | **lite** | `why is` 教學型 |
| JWT auth middleware bug (how to fix?) | **ultra** | `how do I fix` 除錯型 |
| PostgreSQL connection pool (how do I?) | **lite** | `how do I set up` 說明型 |
| git rebase vs merge (explain) | **lite** | `explain` 說明型 |
| callback → async/await (refactor) | **full** | `refactor` 實作型 |
| microservices vs monolith (debate) | **full** | 無明確信號 → full |
| Express route security (review) | **lite** | `security` 安全覆寫 |
| Multi-stage Dockerfile (write) | **full** | 無明確信號 → full |
| Race condition PostgreSQL (how to fix?) | **ultra** | `how do I fix` 除錯型 |
| React error boundary (implement) | **full** | `implement` 實作型 |

**分布**：lite 4 / full 4 / ultra 2

---

## 預期效能增益

基於 caveman 官方 benchmark 數據（output token 節省率）：

| Condition | 預期 Output 節省 vs Baseline | 說明 |
|-----------|:---------------------------:|------|
| Baseline | 0% | 參照基準 |
| Full（session 預設）| ~65-70% | caveman full 標準壓縮 |
| Forced Lite | ~45-55% | 較保守，保留完整句子 |
| Forced Ultra | ~75-80% | 最大壓縮，部分情境失去清晰度 |
| **Auto Mode** | **~68-74%（估算）** | 根據內容選擇最適等級 |

**Auto Mode 優勢**：
- vs Forced Lite：對 ultra 型 prompt 額外多省 ~20-25%
- vs Forced Full：整體輸出更簡潔
- vs Forced Ultra：對說明型 prompt 保持可讀性（lite 模式）

---

## Benchmark 執行方式

```bash
# 1. 快速 dry run（不打 API，確認設定）
python3 benchmarks/run-auto-benchmark.py --dry-run

# 2. 快速測試：Haiku only, 1 trial（最省費用）
python3 benchmarks/run-auto-benchmark.py --trials 1 --models haiku

# 3. 標準測試：三模型，2 trials
python3 benchmarks/run-auto-benchmark.py --trials 2

# 4. 完整測試：三模型，3 trials（與 caveman 官方相同）
python3 benchmarks/run-auto-benchmark.py --trials 3
```

### 費用估算（2025 價格）

| 組合 | API Calls | 預估費用 |
|------|:---------:|:--------:|
| Haiku only, 1 trial | 50 | ~$0.02 |
| Haiku only, 2 trials | 100 | ~$0.05 |
| 三模型, 2 trials | 300 | ~$0.50-1.00 |
| 三模型, 3 trials | 450 | ~$0.75-1.50 |

### 結果位置

```
benchmarks/results/
  auto_benchmark_haiku_<timestamp>.md    # Haiku 模型報告
  auto_benchmark_sonnet_<timestamp>.md   # Sonnet 模型報告
  auto_benchmark_opus_<timestamp>.md     # Opus 模型報告
  auto_benchmark_<timestamp>.json        # 完整原始數據
```

---

## 模型比較

### 測試模型

| Key | Model ID | 說明 |
|-----|----------|------|
| opus | claude-opus-4-6 | 最強，最貴，測試壓縮對品質影響 |
| sonnet | claude-sonnet-4-6 | 平衡，標準工作首選 |
| haiku | claude-haiku-4-5-20251001 | 最快最便宜，日常使用 |

### 預期發現

1. **Haiku**：壓縮效果最大（更容易被系統提示影響），節省率可能最高
2. **Opus**：壓縮率略低但品質最穩定，ultra 模式保留技術精確性
3. **Sonnet**：介於兩者之間
4. **Auto vs Manual**：Auto 模式在 lite 型 prompt 上品質優於 forced-ultra；在 ultra 型 prompt 上節省超過 forced-full

---

## 實作完整性驗證

```bash
# 測試 auto-classifier hook
echo '{"prompt":"fix this bug"}' | CAVEMAN_AUTO_MODE=true node .claude/hooks/caveman-auto-classifier.js
# 預期輸出: {"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"CAVEMAN AUTO: level=ultra..."}}

echo '{"prompt":"explain how React works in detail"}' | CAVEMAN_AUTO_MODE=true node .claude/hooks/caveman-auto-classifier.js
# 預期輸出: {"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"CAVEMAN AUTO: level=lite..."}}

# 測試 statusline
echo "auto:ultra" > ~/.claude/.caveman-active && bash .claude/hooks/caveman-statusline.sh
# 預期輸出: [CAVEMAN:AUTO:ULTRA]（紅色）

echo "auto:lite" > ~/.claude/.caveman-active && bash .claude/hooks/caveman-statusline.sh
# 預期輸出: [CAVEMAN:AUTO:LITE]（綠色）
```

---

## 開關方式

| 方式 | 效果 |
|------|------|
| `CAVEMAN_AUTO_MODE=true`（settings.json env）| 啟用（目前已設定）|
| `CAVEMAN_AUTO_MODE=false` | 停用 |
| `/caveman ultra` | 手動強制 ultra，停用 auto |
| `/caveman lite` | 手動強制 lite，停用 auto |
| `/caveman auto` | 重新啟用 auto mode |
| `stop caveman` | 完全停用 caveman |
