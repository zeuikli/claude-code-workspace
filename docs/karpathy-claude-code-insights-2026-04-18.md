# Karpathy × Claude Code 洞察研究報告

> 日期：2026-04-18
> 分支：`claude/research-claude-best-practices-2H77l`
> 方法：4 個 researcher sub-agent 平行蒐集 → advisor 審核 → 主對話合成
> tags: [karpathy, claude-code, best-practices, research, verification]

---

## TL;DR

1. Karpathy 的 CLAUDE.md **四大核心原則**（Think / Simplicity / Surgical / Goal-Driven）可將 AI coding 準確度從 65-70% 提升至 91-94%（Forrest Chang 實驗數據，非 Karpathy 本人聲稱）。
2. 他個人從「80% 手動編碼」轉為「80% Agent 驅動編碼」——稱為「20年來最大工作流轉變」。
3. **「Vibe Coding」已演進為 Agentic Engineering**：從直覺放鬆轉向紀律性 Agent 編排。
4. 四大原則中三條（Simplicity / Surgical / Goal-Driven）本 workspace 已有對應規則；**「Think Before Coding（顯露假設）」明顯缺失**，列為 follow-up。
5. 官方文件驗證：Lazy-load 規則、Sub-agent 分層、Hook 系統有明確官方支持；「CLAUDE.md < 200 行」是**社群慣例而非官方規定**，與 MEMORY.md 的 200 行 / 25KB 限制不同。

---

## 一、Karpathy 的 4 大 CLAUDE.md 原則

> ⚠️ 以下整理自社群分析（forrestchang/andrej-karpathy-skills、Medium 等），非 Karpathy 本人倉庫或官方文章。來源在 §7。

### 1. Think Before Coding（顯露假設）

> 「顯式陳述假設，當有困惑時說出來而非盲目推進；有多個解釋時列舉選項讓使用者選擇。」

**本 workspace 對應**：`opus47-best-practices.md` 提到「第一輪就完整交代：意圖、限制、驗收條件」，但**沒有要求 Claude 在開始實作前先說出自己的理解和假設**。這是最顯著的缺口。

---

### 2. Simplicity First（簡潔優先）

> 「寫最少的程式碼解決問題。200 行能寫成 50 行就重寫。無推測性功能。」

**本 workspace 對應**：`core.md` 有「不添加需求之外的功能」和「三條類似程式碼優於過早抽象」。✅ 已覆蓋。

---

### 3. Surgical Changes（精準修改）

> 「只改動必要部分；不重構無故障程式碼；匹配既有風格和慣例。」

**本 workspace 對應**：`core.md` 明確要求「不添加超出任務範圍的改動」、「不要重構、清理」。✅ 已覆蓋。

---

### 4. Goal-Driven Execution（目標驅動）

> 「將模糊請求轉化為可量化的成功指標；分步驟執行並加入驗證檢查點。」

**本 workspace 對應**：`opus47-best-practices.md` 的「task-upfront pattern」（意圖、限制、Acceptance Criteria）。✅ 已覆蓋。

---

## 二、AutoResearch —— Eval-Driven 改進模式

**來源**：Karpathy 本人的 GitHub 倉庫 `karpathy/autoresearch`（確認為本人發布）。

**核心設計（3 組件 + 5 步迴圈）**：

```
[Eval 檔案] → [Pass Rate 追蹤] → 改進迴圈：
  execute → calculate → analyze failures
  → generate candidate prompts → retest → select best
```

**關鍵數據**：Karpathy 讓 AutoResearch 自主跑 2 天，發現 20 個優化，包含他手動調整數月未找到的 bug。

**對本 workspace 的啟示**：
- 本 workspace 目前缺乏「prompt 效能量測 → 自動迭代」機制
- `context-report` skill 提供 session 效率量測，但是在 session 結束後分析
- **建議**（列為 follow-up）：設計一個 eval-driven 迴圈，定期量測 sub-agent 的任務完成準確率

---

## 三、「Vibe Coding」→「Agentic Engineering」演進路徑

| 階段 | 時間 | 定義 | 核心特徵 |
|------|------|------|---------|
| **Vibe Coding** | 2025 年 2 月 | 完全沉浸直覺，忘記程式碼存在 | 自然語言驅動、放鬆、成果可拋棄 |
| **Agentic Engineering** | 2025 年底 ~ 現在 | 紀律性 Agent 編排與監督 | 目標驅動、Eval 量測、結構化配置 |

**Karpathy 的工作流轉變**（本人 X 發言，2026 年初）：
- 2024 年底前：80% 手動寫程式碼
- 2025 年後：80% 讓 Agent 完成，自己轉為架構師和審查員
- 2026 年：轉向「LLM Wiki」——用 LLM 建立和維護結構化知識庫

---

## 四、官方文件交叉驗證

| Karpathy / 社群建議 | 官方支持度 | 官方依據 |
|---------------------|-----------|---------|
| **Lazy-load 規則**（常駐 vs 按需） | ✅ 完全支持 | CLAUDE.md 和 MEMORY.md 分層設計；文件明確建議精簡常駐載入 |
| **Sub-agent 分層**（Haiku/Sonnet/Opus） | ✅ 完全支持 | 官方模型選型指南：依複雜度分層；Agent SDK 文件 |
| **Hook 系統**（事件驅動自動化） | ✅ 完全支持 | 官方文件列出 12+ 事件；2026 年 1-2 月新增 async + HTTP hooks |
| **量化 context 使用** | ⚠️ 部分支持 | 官方建議 MEMORY.md ≤ 25KB；無 session token 量測工具（需自製如 `context-report` skill） |
| **CLAUDE.md < 200 行** | ❌ 無官方規定 | 官方未設長度限制（此限制來自社群慣例）；**注意：200 行 / 25KB 是 MEMORY.md 的限制，不是 CLAUDE.md** |
| **SKILL.md < 500 行** | ❌ 無官方規定 | 社群約定（htlin222 / forrestchang 等）；官方文件未提 |
| **Think Before Coding（假設顯露）** | ⚠️ 間接支持 | 官方 best-practices 提到「給 Claude 驗證能力」；Plan Mode 設計理念接近 |
| **AutoResearch / Eval-driven 迴圈** | ⚠️ 間接支持 | 官方提及「let Claude verify」；無原生 eval loop 工具 |

**重要澄清**：
> MEMORY.md 的 200 行 / 25KB 上限 = 官方規定（超過不載入）
> CLAUDE.md 的「< 200 行」= 社群最佳實踐（減少 token、保持可讀性）

---

## 五、Gap Matrix — workspace 現況 vs Karpathy 建議

| Karpathy 建議 | workspace 現況 | 評估 |
|--------------|---------------|------|
| Think Before Coding | ❌ 無對應規則 | **缺口** — follow-up P1 |
| Simplicity First | `core.md` 有類似原則 | ✅ 已覆蓋 |
| Surgical Changes | `core.md` 明確要求 | ✅ 已覆蓋 |
| Goal-Driven / Acceptance Criteria | `opus47-best-practices.md` | ✅ 已覆蓋 |
| AutoResearch / Eval loop | `context-report` skill（部分） | ⚠️ 部分覆蓋 |
| 量化效率 | `context-report` skill 完整 | ✅ 已覆蓋 |
| Sub-agent 分層 | `subagent-strategy.md` | ✅ 已覆蓋 |
| Lazy-load rules | CLAUDE.md 表格 | ✅ 已覆蓋 |
| Hook 事件覆蓋 | 9 個 hooks、7 種事件 | ✅ 已覆蓋 |
| LLM Wiki 知識累積 | Auto Memory + Memory.md | ✅ 架構對齊 |

---

## 六、Follow-up Backlog（本輪不實作）

### P1（高優先級）
- [ ] **新增「Think Before Coding」規則**：在 `core.md` 或獨立 rule 中加入「實作前先說出假設 + 列舉多個解釋方案」的要求；對應 `opus47-best-practices.md` 的 task-upfront pattern

### P2（中優先級）
- [ ] **Eval-driven prompt 優化**：設計一個類 AutoResearch 的 skill，定期量測 sub-agent 任務完成率，追蹤 prompt 版本效果（需要測試資料集設計）
- [ ] **LLM Wiki skill**：建立一個整理研究發現成結構化 markdown 知識庫的 skill（類似現有 `research-best-practices`，但聚焦在知識累積而非 gap analysis）

### P3（低優先級）
- [ ] 澄清 workspace 文件中 CLAUDE.md vs MEMORY.md 長度限制的說明，避免混淆

---

## 七、Sources

| 來源 | 類型 | 可信度 |
|------|------|-------|
| `github.com/karpathy/autoresearch` | Karpathy **本人** repo | ★★★★★ |
| `karpathy.bearblog.dev/year-in-review-2025/` | Karpathy **本人** blog | ★★★★★ |
| `x.com/karpathy`（vibe coding 原帖） | Karpathy **本人** tweet | ★★★★★ |
| `github.com/forrestchang/andrej-karpathy-skills` | **社群解讀**（非本人）| ★★★☆☆ |
| Medium / MindStudio 等分析文章 | **第三方分析**（非本人）| ★★☆☆☆ |
| `docs.anthropic.com/en/claude-code/*` | **官方文件** | ★★★★★ |

> ⚠️ `forrestchang/andrej-karpathy-skills` 是社群受 Karpathy 啟發建立的倉庫，**不是 Karpathy 本人倉庫**。91-94% 準確度數據來自該倉庫的個人實驗，不是 Karpathy 本人的聲明。
