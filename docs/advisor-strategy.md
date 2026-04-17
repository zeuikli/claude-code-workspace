# Advisor Strategy — 顧問模式指南

> **核心理念**：Haiku 4.5 / Sonnet 4.6 跑主迴圈當執行者，Opus 4.7 退居幕後當「顧問」。
>
> 基於 [AgentOpt 論文](https://arxiv.org/html/2604.06296v1)、[Anthropic 官方 Advisor Strategy](https://claude.com/blog/the-advisor-strategy)、[Opus 4.7 Best Practices](https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code) 整理。
>
> 最後更新：2026-04-17（Opus 4.7 GA）

---

## 為什麼要用顧問模式？

### 傳統做法的問題

傳統思維是把最強的模型（Opus）放在主迴圈驅動一切，便宜模型只做收尾。但 AgentOpt 論文發現了一個反直覺的結論：

> **最貴的模型放在規劃者（Planner）位置，反而表現最差。**

| 組合 | 準確率 | 原因 |
|------|--------|------|
| Opus 當規劃者 + 任何執行者 | **31.71%** | Opus 太強，直接裸答跳過工具使用 |
| Ministral 8B 當規劃者 + Opus 當執行者 | **74.27%** | 弱模型主動分解問題、善於委派 |

**根本原因**：能力過強的模型傾向於繞過架構設計的流程，直接嘗試回答而非委派。能力有限的模型反而更忠實地遵循分工結構。

### 成本差距驚人

在準確率相近的情況下，最佳和最差的模型組合：

| 任務 | 成本差距 |
|------|----------|
| HotpotQA（多跳問答） | **21 倍** |
| MathQA（數學推理） | **118 倍** |
| BFCL（函數呼叫） | **32 倍** |

---

## 顧問模式架構

```
┌─────────────────────────────────────────────────────┐
│              Agent 主迴圈（Executor）                  │
│            模型：Haiku 或 Sonnet                      │
│                                                      │
│  1. 接收任務                                          │
│  2. 讀取檔案、呼叫工具、逐步推進                        │
│  3. 遇到困難 → 諮詢 Advisor                           │
│              ↓                                       │
│  ┌────────────────────────────┐                      │
│  │   Advisor（顧問）            │                     │
│  │   模型：Opus                │                      │
│  │                            │                      │
│  │  - 接收精選的上下文          │                      │
│  │  - 回傳策略建議（400-700 token）│                   │
│  │  - 不直接呼叫工具            │                      │
│  │  - 不產生面向使用者的輸出      │                     │
│  └────────────────────────────┘                      │
│              ↓                                       │
│  4. 根據 Advisor 建議繼續執行                          │
│  5. 完成任務、回報結果                                 │
└─────────────────────────────────────────────────────┘
```

### 角色分工

| 角色 | 模型 | 職責 | 特性 |
|------|------|------|------|
| **執行者（Executor）** | Haiku 4.5 / Sonnet 4.6 | 驅動主迴圈、呼叫工具、讀寫檔案、產出結果 | 快速、便宜、忠實遵循流程 |
| **顧問（Advisor）** | Opus 4.7（`xhigh`） | 提供高階策略、架構決策、邊界案例判斷 | 按需出場、僅回傳建議（400–700 token）|

---

## 官方 API 實作

Anthropic 官方提供了 `advisor_20260301` 工具類型，在單次 `/v1/messages` 請求內完成 Sonnet→Opus 升級，無需額外往返：

```python
import anthropic

client = anthropic.Anthropic()

response = client.messages.create(
    model="claude-sonnet-4-6",  # 執行者（Sonnet 4.6）
    tools=[
        {
            "type": "advisor_20260301",
            "name": "advisor",
            "model": "claude-opus-4-7",  # 顧問（Opus 4.7）
            "max_uses": 3,  # 每次請求最多諮詢 3 次（控制成本）
        },
        # ... 其他工具（搜尋、程式碼執行等）
    ],
    messages=[
        {"role": "user", "content": "請幫我重構這個 API 模組..."}
    ],
)

# Advisor token 使用量在 usage block 中獨立回報
# advisor_tokens = response.usage.advisor_tokens
```

### 參數說明

| 參數 | 說明 |
|------|------|
| `model`（外層） | 執行者模型：`claude-sonnet-4-6` 或 `claude-haiku-4-5-20251001` |
| `type` | 固定為 `advisor_20260301` |
| `model`（工具內） | 顧問模型：`claude-opus-4-7`（推薦）或 `claude-opus-4-6` |
| `max_uses` | 每次 API 請求中，執行者最多可諮詢顧問的次數（建議 2–5） |

### 計費說明

- Advisor token 按顧問模型費率計算，Executor token 按執行者費率計算。
- Advisor 通常只產出 400–700 token 的建議，整體成本遠低於直接用 Opus 跑全程。
- 在 usage block 中可獨立追蹤 advisor_tokens，方便成本監控。

---

## 效能基準

### Sonnet + Opus Advisor

| 指標 | Sonnet 單獨 | Sonnet + Opus Advisor | 差異 |
|------|------------|----------------------|------|
| SWE-bench 多語言 | 基準 | **+2.7 百分點** | 準確率提升 |
| 每任務成本 | 基準 | **-11.9%** | 成本反而降低 |
| BrowseComp | 基準 | 提升 | 同時省錢 |

### Haiku + Opus Advisor

| 指標 | Haiku 單獨 | Haiku + Opus Advisor | 差異 |
|------|-----------|---------------------|------|
| BrowseComp | 19.7% | **41.2%** | 效能翻倍 |
| 相比 Sonnet 單獨 | — | 效能差 29% | 但成本僅 **15%** |

### 選型建議

| 場景 | 推薦組合 | 理由 |
|------|----------|------|
| **標準開發** | Sonnet + Opus Advisor | 效能最佳平衡點 |
| **高量批次作業** | Haiku + Opus Advisor | 成本極低，效能可接受 |
| **純推理 / 研究** | Opus 單獨 | 不需要工具呼叫的深度思考 |
| **簡單任務** | Haiku / Sonnet 單獨 | 不需要顧問的額外開銷 |

---

## Claude Code 中的實踐

在 Claude Code 的 agentic 環境中，可透過以下方式實踐顧問模式：

### 1. Sub Agent 分層委派

```
主對話（Sonnet / Haiku 主迴圈）
├── 一般搜尋、檔案讀寫 → Haiku Sub Agent
├── 程式碼實作、測試 → Sonnet Sub Agent
└── 架構決策、複雜判斷 → Opus Sub Agent（顧問角色）
```

### 2. 何時諮詢 Opus 顧問

- 涉及**架構層級**的設計決策
- 需要**跨模組分析**的重構判斷
- 遇到**邊界案例**或不確定的技術選型
- 需要**程式碼審查**複雜邏輯的正確性
- **安全性審計**（注入漏洞、認證缺陷）

### 3. 不需諮詢 Opus 的情境

- 簡單的檔案搜尋與讀取
- 格式化、重新命名、型別標註
- 已知模式的重複性工作
- 執行測試、lint 等標準流程

---

## 關鍵原則

1. **模型能力 ≠ 管線效能**：最強的模型放錯位置反而拖累整體。
2. **善於委派 > 獨自解決**：執行者的價值在於忠實分工，而非獨立思考。
3. **按需諮詢，而非全程駕馭**：Opus 只在關鍵時刻介入，其餘時間不消耗 token。
4. **系統化驗證**：不靠直覺選模型，讓實際效能數據說話。
5. **成本意識**：同樣準確率下，組合差異可達 **13–32 倍**成本。

---

## Opus 4.7 在 Advisor 模式中的特性

> 來源：[Best practices for using Claude Opus 4.7 with Claude Code](https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code)

### 建議以 `xhigh` 努力級別運作

Opus 4.7 的預設努力級別為 `xhigh`（介於 `high` 和 `max` 之間），是 Advisor 角色的最佳設定：
- 提供強大的推理能力，適合架構決策與邊界案例分析
- 不會像 `max` 那樣過度思考導致 token 暴增

### 自適應思考（Adaptive Thinking）

Opus 4.7 不支援固定 thinking budget，改用自適應思考：
- 簡單查詢：直接回應，跳過推理步驟
- 複雜問題：自動投入更多推理 token

**引導 Advisor 深度思考：**
```
Think carefully and step-by-step before responding; this is an architecture-critical decision.
```

### 首輪前置規格原則

對 Opus 4.7 下任務時，第一輪就給完整規格效果最好：
- 意圖（為什麼做）
- 限制（不能做什麼）
- 驗收標準（怎樣算完成）
- 相關檔案路徑

這樣可以減少互動次數，也避免 Opus 4.7 在多輪對話中累積過多 token。

---

## 參考資料

- [AgentOpt: Expensive Models in the Wrong Position](https://arxiv.org/html/2604.06296v1) — 論文原文
- [AgentOpt 繁體中文解讀](https://ai-coding.wiselychen.com/agentopt-expensive-model-wrong-position-pipeline-optimization/)
- [The Advisor Strategy — Anthropic 官方](https://claude.com/blog/the-advisor-strategy)
- [Best practices for using Claude Opus 4.7 with Claude Code](https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code)
- [1M context is now generally available](https://claude.com/blog/1m-context-ga)
