---
description: Sub Agent 策略 + Advisor 模式 + 委派規則（已針對 Opus 4.7 行為更新）
---

# Sub Agent 策略與 Advisor 模式

## 基本原則

- **IMPORTANT**: 能用 Sub Agent 處理的請求，**優先使用 Sub Agent**，避免主對話 context 被大量檔案讀取佔滿。
- 每次任務開始時，依情境自動指派一個**主 Agent (Lead Agent)**，負責：
  - 協調所有 Sub Agent 的分工
  - 使用 `TodoWrite` 追蹤並更新所有 Todo 與 Checklist
  - 任務完成後向使用者回報進度摘要
- 調查與研究任務必須委派 Sub Agent 執行，主對話僅接收摘要結果。

## Opus 4.7 委派行為注意事項

> 來源：[Best practices for using Claude Opus 4.7 with Claude Code](https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code)

Opus 4.7 相比前版**預設委派更保守**（spawns fewer subagents by default）。需要平行展開時**必須顯式說明**：

```
# 需要平行工作時，明確指示（而非讓模型自行判斷）：
請同時啟動多個 Sub Agent 處理以下獨立任務：
1. 探索 src/api/ 下所有路由
2. 分析 src/models/ 的資料結構
3. 檢查 src/auth/ 的認證流程
各自回傳摘要，不要回傳完整檔案內容。

# 相反地，不需要委派時也要說清楚：
不要對你能直接回答的工作啟動 Sub Agent（如：重構可見的函式、簡單搜尋）。
```

## Advisor 模式（顧問策略）

> 依據 [AgentOpt 論文](https://arxiv.org/html/2604.06296v1) 與 [Anthropic Advisor Strategy](https://claude.com/blog/the-advisor-strategy)

- **IMPORTANT**: 主迴圈由 **Haiku 4.5 / Sonnet 4.6 擔任執行者**，**Opus 4.7 退居幕後當顧問**。
- 執行者負責：驅動任務、讀寫檔案、呼叫工具、逐步推進。
- 顧問負責：僅在關鍵時刻提供策略建議，不直接操作（回應約 400–700 token）。
- API 層可使用 `advisor_20260301` 工具實現單次請求內的 Sonnet→Opus 升級（見 docs/advisor-strategy.md）。
- **何時諮詢 Opus 4.7 顧問**：
  - 架構層級的設計決策或跨模組重構
  - 邊界案例判斷與不確定的技術選型
  - 複雜邏輯的程式碼審查與安全性審計
- **不需諮詢 Opus 4.7**：簡單搜尋、格式化、已知模式的重複性工作、執行測試與 lint。
- Sub Agent 模型分層：`Haiku 4.5`（搜尋 / 探索）→ `Sonnet 4.6`（實作 / 測試）→ `Opus 4.7`（架構 / 審查）。
- 詳細說明：見 `docs/advisor-strategy.md`（按需 lazy-load）

## Sub Agent 委派規則

- **研究型任務**（>10 檔案）：使用 `researcher` 或 `architecture-explorer`（Haiku 4.5）
- **平行獨立工作**（3+ 子任務）：同時啟動多個 Sub Agent，**必須在 prompt 中明確要求**
- **程式碼實作**：使用 `implementer`（Sonnet 4.6）
- **測試撰寫**：使用 `test-writer`（Sonnet 4.6）
- **安全審查**：使用 `security-reviewer`（Sonnet 4.6），非必要不調用 Opus 4.7
- **架構決策**：僅此情境使用 `reviewer`（Opus 4.7），使用 `xhigh` 努力級別
- **Commit 前驗證**：使用 `/deep-review` Skill 執行三維度平行審查
- **前端開發**：自動載入 `frontend-design` Skill 避免 AI slop

## 工具使用引導（Opus 4.7 特有）

Opus 4.7 **預設工具呼叫次數較少**。需要積極搜尋或讀檔時，明確說明觸發條件：

```
進行 agentic 作業時，請積極使用 Grep 和 Read 工具確認現有程式碼，
每個假設都應由工具呼叫驗證而非直接推斷。
```
