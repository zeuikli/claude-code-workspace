---
description: Sub Agent 策略 + Advisor 模式 + 委派規則（Opus 4.7 調校）
---

# Sub Agent 策略與 Advisor 模式

## 基本原則

- **IMPORTANT**: 能用 Sub Agent 處理的請求，**優先使用 Sub Agent**，避免主對話 context 被大量檔案讀取佔滿（context rot）。
- 每次任務開始時，依情境自動指派一個**主 Agent (Lead Agent)**，負責：
  - 規劃分工與呼叫 `TodoWrite`
  - 協調所有 Sub Agent
  - 任務完成後回報**摘要**（不是原始檔案內容）
- 調查與研究任務必須委派 Sub Agent 執行，主對話僅接收摘要結果。

## Opus 4.7 的 subagent 行為差異

- **IMPORTANT**: Opus 4.7 預設**較少自動開 subagent**，需要平行化時**必須明確指示**，否則會傾向直接在主對話解決。
- 判斷原則（Anthropic 官方心智模型）：
  > **Will I need this tool output again, or just the conclusion?**
  - 只需要結論 → 委派 subagent（中間產物留在 child context）
  - 需要反覆檢視中間產物 → 主對話自己做
- 建議的明確指示語：
  > 「Spawn multiple subagents in the same turn when fanning out across items or reading multiple files. Do not spawn a subagent for work you can complete directly in a single response.」

## Advisor 模式（顧問策略）

- **IMPORTANT**: 主迴圈由 **Sonnet 4.6 / Haiku 4.5 擔任執行者**，**Opus 4.7 退居幕後擔任顧問**。
- 執行者負責：驅動任務、讀寫檔案、呼叫工具、逐步推進。
- 顧問負責：僅在關鍵時刻提供策略建議，不直接操作（回應約 400–700 token）。
- API 層可使用 `advisor_20260301` 工具實現單次請求內的 Sonnet→Opus 升級（見 docs/advisor-strategy.md）。
> ⚠️ 工具 ID 可能隨版本更新，以官方文件為準。
- **何時諮詢 Opus 4.7 顧問**：
  - 架構層級的設計決策或跨模組重構
  - 邊界案例判斷與不確定的技術選型
  - 複雜邏輯的程式碼審查與安全性審計
  - **長 session 的 recovery（如 compact 後的接手）**
- **不需諮詢 Opus**：簡單搜尋、格式化、已知模式的重複性工作、執行測試與 lint。
- Sub Agent 模型分層：
  - `Haiku 4.5`（搜尋 / 探索）→ 速度與成本最佳
  - `Sonnet 4.6`（實作 / 測試）→ 日常主力
  - `Opus 4.7`（架構 / 審查 / 疑難雜症）→ 僅在必要時
- 詳細說明：見 `docs/advisor-strategy.md`（按需 lazy-load）

## Sub Agent 委派規則

- **研究型任務**（>10 檔案）：使用 `researcher` 或 `architecture-explorer`（Haiku 4.5）
- **平行獨立工作**（3+ 子任務）：**單一訊息同時啟動多個 Sub Agent**（Opus 4.7 不會自動這麼做，需明確指示）
- **程式碼實作**：使用 `implementer`（Sonnet 4.6）
- **測試撰寫**：使用 `test-writer`（Sonnet 4.6）
- **安全審查**：使用 `security-reviewer`（Sonnet 4.6），非必要不調用 Opus
- **架構決策**：僅此情境使用 `reviewer`（Opus 4.7），使用 `xhigh` 努力級別
- **Commit 前驗證**：使用 `/deep-review` Skill 執行三維度平行審查
- **前端開發**：自動載入 `frontend-design` Skill 避免 AI slop

## 漸進式委派策略

- 先讓主對話處理，若發現：
  1. 將產生大量中間輸出（tool noise）
  2. 需要讀 10+ 檔案
  3. 可拆成 3+ 獨立子任務
- 才切換為 subagent。避免過早優化。

## 工具設計心智模型（lazy-load）

> 設計新 Skill / Agent / Tool 前，按需 Read `docs/tool-design-principles.md`。
> 觸發條件：要新增 `.claude/agents/` 或 `.claude/skills/` 時。

## 工具使用引導（Opus 4.7 每輪適用）

Opus 4.7 **預設工具呼叫次數較少**。agentic 作業時明確要求積極驗證：

```
積極使用 Grep 和 Read 確認現有程式碼，每個假設應由工具呼叫驗證而非直接推斷。
```
