---
description: Sub Agent 策略 + Advisor 模式 + 委派規則（核心常駐版）
tier: auto
---

# Sub Agent 策略與 Advisor 模式

## 基本原則

- **IMPORTANT**: 能用 Sub Agent 處理的請求，**優先使用 Sub Agent**，避免主對話 context 被大量檔案讀取佔滿（context rot）。
- 每次任務開始時，依情境自動指派一個**主 Agent (Lead Agent)**，負責：
  - 規劃分工與呼叫 `TodoWrite`
  - 協調所有 Sub Agent
  - 任務完成後回報**摘要**（不是原始檔案內容）
- 調查與研究任務必須委派 Sub Agent 執行，主對話僅接收摘要結果。

## Advisor 模式（顧問策略）

- **IMPORTANT**: 主迴圈由 **Sonnet 4.6 / Haiku 4.5 擔任執行者**，**Opus 4.7 退居幕後擔任顧問**。
- 執行者負責：驅動任務、讀寫檔案、呼叫工具、逐步推進。
- 顧問負責：僅在關鍵時刻提供策略建議，不直接操作（回應約 400–700 token）。
- **何時諮詢 Opus 4.7 顧問**：
  - 架構層級的設計決策或跨模組重構
  - 邊界案例判斷與不確定的技術選型
  - 複雜邏輯的程式碼審查與安全性審計
  - 長 session 的 recovery（如 compact 後的接手）
- **不需諮詢 Opus**：簡單搜尋、格式化、已知模式的重複性工作、執行測試與 lint。
- Sub Agent 模型分層：
  - `Haiku 4.5`（搜尋 / 探索）→ 速度與成本最佳
  - `Sonnet 4.6`（實作 / 測試）→ 日常主力
  - `Opus 4.7`（架構 / 審查 / 疑難雜症）→ 僅在必要時

## Sub Agent 委派規則

- **研究型任務**（>10 檔案）：使用 `researcher` 或 `architecture-explorer`（Haiku 4.5）
- **平行獨立工作**（3+ 子任務）：**單一訊息同時啟動多個 Sub Agent**
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

> **進階**：Opus 4.7 subagent 行為差異、Tasks 跨 session 協作、工具使用引導
> → 按需載入 `.claude/rules/subagent-advanced.md`（觸發詞：Tasks、Opus 調校、多 Agent 協調）
