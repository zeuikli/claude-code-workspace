---
description: 工具設計的心智模型（Seeing like an agent）— 按需載入
source: https://claude.com/blog/seeing-like-an-agent (archive: archive/articles/seeing-like-an-agent.md)
---

# 工具設計心智模型：Seeing Like an Agent

> 原從 `.claude/rules/subagent-strategy.md` 抽出至 lazy-load，降低啟動 context。

## 核心問句

設計工具前先自問：
> 「想像 Claude 是一個拿到難題的人，它需要什麼樣的工具才能解出來？」

工具要**配合模型自身能力**，而非堆疊一切「能做的事」。

## 四個關鍵原則

### 1. 高門檻加新工具
每加一個工具都是 Claude 必須思考的選項，造成 context rot。
- 先嘗試 Skill / Progressive Disclosure
- 再談新增工具

### 2. Progressive Disclosure（漸進揭露）
不要預載所有指令到 system prompt，讓 Claude 按需探索：
- `.claude/skills/`（按觸發條件啟動）
- `@docs/...`（lazy-load 引用）
- doc 連結（需要時 Read）

### 3. 動作分類
| 動作特性 | 升級方式 |
|---------|---------|
| 需要 security boundary | 專用工具 |
| 需要 UX 透出 / audit | 專用工具 |
| 其餘 | 用 bash |

- 不可逆動作 → user confirmation
- write 工具 → 加 staleness check

### 4. Subagent = 不新增工具的動作空間擴充
Claude Code 用 `claude-code-guide` subagent 處理「如何使用 Claude Code」的問題，保持主 agent 的 context 乾淨。

## 對本 workspace 的應用

- `.claude/skills/` 的 Skill **優先於**新增 agent
- `docs/` 的深入文件用 `@path` 延遲載入，**不進 CLAUDE.md** 主文
- 新增 Subagent 前先問：「這能用 Skill 或既有 Agent 達成嗎？」

## Opus 4.7 工具使用引導

Opus 4.7 預設工具呼叫次數較少。需要積極搜尋/讀檔時，明確指示：

```
進行 agentic 作業時，請積極使用 Grep 和 Read 工具確認現有程式碼，
每個假設都應由工具呼叫驗證而非直接推斷。
```
