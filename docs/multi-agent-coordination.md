# Multi-Agent Coordination Patterns（5 種協調模式決策表）

> 來源：[Multi-agent coordination patterns: Five approaches and when to use them](https://claude.com/blog/multi-agent-coordination-patterns)（2026-04-10）
> 適用範圍：本 workspace 選擇「平行 subagent 架構」前的決策參考。Lazy-load，不進 CLAUDE.md 主文。

## TL;DR 決策表

| 情境 | 推薦模式 | 本 workspace 的對應實作 |
|------|---------|----------------------|
| 品質關鍵、評估準則明確 | **Generator-Verifier** | `/deep-review` Skill（三維度平行審查） |
| 可清楚拆解、子任務邊界明確 | **Orchestrator-Subagent** | `.claude/agents/`（researcher / implementer / reviewer …） |
| 長跑平行、獨立子任務 | **Agent Teams** | `.claude/skills/agent-team/`（已存在的 Skill） |
| 事件驅動 pipeline、agent 生態成長 | **Message Bus** | 未實作（routines webhook 可作為前身） |
| 協作式研究、agent 建構共享知識 | **Shared State** | 未實作（Auto Memory 是單 agent 版） |
| 要消除 single point of failure | **Shared State** | — |

**官方建議**：大多數情況先從 `Orchestrator-Subagent` 開始，遇到瓶頸再演進。

---

## 1. Generator-Verifier

**機制**：Generator 產出 → Verifier 依準則驗證 → 不通過則回饋重做。

**適用**：程式碼產出（一方寫碼、一方寫並執行測試）、事實查核、rubric 評分、合規驗證。

**陷阱**：
- Verifier 只和準則一樣好 — 沒有明確準則的 verifier 等於橡皮圖章。
- 若「評估」和「生成」難度相當，verifier 無法可靠抓問題。
- 設最大迭代次數 + fallback（升級人工 / 帶註記回傳最佳嘗試），避免無限迴圈。

**本 workspace 實作**：`.claude/skills/deep-review/SKILL.md` 以安全 / 效能 / 風格三維度平行驗證 staged changes。

---

## 2. Orchestrator-Subagent（本 workspace 預設）

**機制**：Lead agent 規劃並委派 → Subagent 各自處理 → Lead 合成結果。Claude Code 本身就是此模式。

**適用**：任務拆解清楚、子任務相互依賴少。例：自動化 code review，一個 subagent 查安全、一個查測試覆蓋率、一個查風格。

**陷阱**：
- Lead 是 information bottleneck — subagent 之間發現的關聯資訊需繞經 lead。
- 未明確平行化時 subagent 會循序執行，付了多 agent 的 token 卻沒拿到速度。

**本 workspace 實作**：
- `.claude/agents/researcher.md`（Haiku 4.5，研究/探索）
- `.claude/agents/implementer.md`（Sonnet 4.6，實作）
- `.claude/agents/reviewer.md`（Opus 4.7，架構）
- `.claude/agents/security-reviewer.md`（Sonnet 4.6，安全）
- `.claude/agents/architecture-explorer.md`（Haiku 4.5，架構映射）
- `.claude/agents/test-writer.md`（Sonnet 4.6，測試）

---

## 3. Agent Teams

**機制**：Coordinator 生出多個**持久 worker**，workers 從共享 queue 取任務、跨多步自主執行、累積領域 context。

**vs Orchestrator-Subagent**：subagent 單任務完成後終止；teammate 跨任務存活、累積專長。

**適用**：大型 codebase 跨服務遷移 — 每個 teammate 專職一個 service，累積對其依賴圖 / 測試 pattern / 部署設定的熟悉度。

**陷阱**：
- 獨立性是硬需求：teammates 無法中介 / 分享中間發現。
- 完成偵測較難：有人兩分鐘、有人二十分鐘。
- 共用資源（同一檔案 / DB）需要明確分區與衝突解決。

**本 workspace 實作**：`.claude/skills/agent-team/SKILL.md`（在 Skill 層提供 Agent Teams 模式指引）。

---

## 4. Message Bus

**機制**：Agent 透過 publish / subscribe 互動；router 依事件主題分派。新能力的 agent 可接新主題而不動現有連線。

**適用**：Security operations — alert 分類到網路調查 agent 或身分分析 agent，各 agent 可再發出豐富化請求，最後 response coordinator 決定動作。

**陷阱**：
- 可追溯性差：一個 alert 觸發五階段 agent 時，要靠 logging 與 correlation 才能還原。
- Router 錯分類會**無聲失敗**（從不 crash 但啥都沒處理）。

**本 workspace 實作**：尚未實作；Claude Code Routines（GitHub webhook / API）是可能的前身，見 `.claude/rules/routines.md`。

---

## 5. Shared State

**機制**：Agents 直接讀寫共享 store（DB / 檔案系統 / 文件），無中央協調者。Seed 觸發、termination condition 收斂。

**適用**：研究綜整 — 學術文獻 agent、產業報告 agent、專利 agent、新聞 agent 的發現互相觸發。學術 agent 發現某研究者 → 產業 agent 立刻看到，無需 router 路由。

**陷阱**：
- 可能重工、走相反方向。
- **Reactive loop**：A 寫、B 反應、A 再反應 → 燒 token 不收斂。必須設 termination（time budget / convergence threshold / 指定 arbiter）。
- 重工與並發寫有既有工程解（lock / version / partition），reactive loop 是行為問題，需要一等公民的終止條件。

**本 workspace 實作**：尚未實作；Auto Memory 目前是單 agent 的跨 session 狀態，非多 agent 共享 state。

---

## 選擇與演進

### Orchestrator-Subagent vs. Agent Teams
Workers 需要跨呼叫保留 context ⇒ Agent Teams。否則 Orchestrator-Subagent。

### Orchestrator-Subagent vs. Message Bus
工作流程預先已知 ⇒ Orchestrator-Subagent。工作流程隨事件浮現 ⇒ Message Bus。

### Agent Teams vs. Shared State
分區獨立、最後合併 ⇒ Agent Teams。需即時共享發現 ⇒ Shared State。

### Message Bus vs. Shared State
離散事件流 ⇒ Message Bus。持續累積知識 ⇒ Shared State。要消除 single point of failure ⇒ Shared State。

### 混合模式
生產環境常混用：Orchestrator-Subagent 做主流程 + Shared State 做某個協作重的子任務；或 Message Bus 做事件路由 + Agent Teams 處理每類事件。五種是**積木**，不是互斥選項。
