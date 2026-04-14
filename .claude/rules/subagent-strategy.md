---
description: Sub Agent 策略 + Advisor 模式 + 委派規則
---

# Sub Agent 策略與 Advisor 模式

## 基本原則

- **IMPORTANT**: 能用 Sub Agent 處理的請求，**優先使用 Sub Agent**，避免主對話 context 被大量檔案讀取佔滿。
- 每次任務開始時，依情境自動指派一個**主 Agent (Lead Agent)**，負責：
  - 協調所有 Sub Agent 的分工
  - 使用 `TodoWrite` 追蹤並更新所有 Todo 與 Checklist
  - 任務完成後向使用者回報進度摘要
- 調查與研究任務必須委派 Sub Agent 執行，主對話僅接收摘要結果。

## Advisor 模式（顧問策略）

> 依據 [AgentOpt 論文](https://arxiv.org/html/2604.06296v1) 與 [Anthropic Advisor Strategy](https://claude.com/blog/the-advisor-strategy)

- **IMPORTANT**: 主迴圈由 **Haiku / Sonnet 擔任執行者**，**Opus 退居幕後當顧問**。
- 執行者負責：驅動任務、讀寫檔案、呼叫工具、逐步推進。
- 顧問負責：僅在關鍵時刻提供策略建議，不直接操作。
- **何時諮詢 Opus 顧問**：
  - 架構層級的設計決策或跨模組重構
  - 邊界案例判斷與不確定的技術選型
  - 複雜邏輯的程式碼審查與安全性審計
- **不需諮詢 Opus**：簡單搜尋、格式化、已知模式的重複性工作、執行測試與 lint。
- Sub Agent 模型分層：`Haiku`（搜尋 / 探索）→ `Sonnet`（實作 / 測試）→ `Opus`（架構 / 審查）。
- 詳細說明：見 `docs/advisor-strategy.md`（按需 lazy-load）

## Sub Agent 委派規則

- **研究型任務**（>10 檔案）：使用 `researcher` 或 `architecture-explorer`（Haiku）
- **平行獨立工作**（3+ 子任務）：同時啟動多個 Sub Agent
- **程式碼實作**：使用 `implementer`（Sonnet）
- **測試撰寫**：使用 `test-writer`（Sonnet）
- **安全審查**：使用 `security-reviewer`（Sonnet），非必要不調用 Opus
- **架構決策**：僅此情境使用 `reviewer`（Opus）
- **Commit 前驗證**：使用 `/deep-review` Skill 執行三維度平行審查
- **前端開發**：自動載入 `frontend-design` Skill 避免 AI slop
