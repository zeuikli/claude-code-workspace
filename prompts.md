# 萬用 Prompt 集

> 複製貼上即可使用，適用於任何 Claude Code session（Opus 4.7 + Sonnet 4.6 優化）。

---

## 1. 標準開場（推薦）

適用於：任何新 session 的第一句話。支援本機（`~/`）與雲端（`/tmp/`）自動偵測。

```
請執行：DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; command -v git >/dev/null 2>&1 && (([ -d "$DIR/.git" ] && git -C "$DIR" pull -q origin main || (rm -rf "$DIR" 2>/dev/null; git clone --depth 1 -q https://github.com/zeuikli/claude-code-workspace.git "$DIR")) && mkdir -p ~/.claude && printf "@${DIR}/CLAUDE.md\n" > ~/.claude/CLAUDE.md)

完成後讀取並遵循 ${DIR}/CLAUDE.md。跨對話記憶由官方 Auto Memory 自動管理。
```

---

## 2. 極簡版（一行）

適用於：已確認 Hook 自動載入的 session，只需驗證。

```
請確認已載入 claude-code-workspace 的 CLAUDE.md，列出目前的指令規則摘要。
```

---

## 3. 接續上次工作

適用於：延續前一個 session 的開發。

```
請載入 workspace 設定，執行 /memory 查看 Auto Memory 中上次的工作進度，接續未完成的項目。如果有待辦事項，用 TodoWrite 列出並開始執行。
```

---

## 4. 新專案初始化

適用於：第一次在某個專案中設定自動載入。

```
請幫我在這個專案建立 .claude/settings.json，加入 SessionStart Hook 自動載入 workspace，並設定 Opus 4.7 xhigh：

{
  "autoMemoryEnabled": true,
  "model": "claude-opus-4-7",
  "effortLevel": "xhigh",
  "alwaysThinkingEnabled": true,
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'DIR=/tmp/claude-code-workspace; [ -d $DIR/.git ] && git -C $DIR pull -q origin main || git clone -q --depth 1 https://github.com/zeuikli/claude-code-workspace.git $DIR; mkdir -p ~/.claude; echo \"@${DIR}/CLAUDE.md\" > ~/.claude/CLAUDE.md'"
          }
        ]
      }
    ]
  }
}

設定完成後 commit 並 push。之後每次開 session 都會自動載入。
```

---

## 5. 完整載入（含 Advisor 策略）

適用於：需要完整載入所有設定與參考文件的複雜任務。

```
請執行：DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; command -v git >/dev/null 2>&1 && (([ -d "$DIR/.git" ] && git -C "$DIR" pull -q origin main || (rm -rf "$DIR" 2>/dev/null; git clone --depth 1 -q https://github.com/zeuikli/claude-code-workspace.git "$DIR")) && mkdir -p ~/.claude && printf "@${DIR}/CLAUDE.md\n" > ~/.claude/CLAUDE.md)

完成後依序讀取並遵循：
1. ${DIR}/CLAUDE.md（專案指令與規則）
2. ${DIR}/docs/advisor-strategy.md（Advisor 模式）
3. ${DIR}/docs/opus47-migration.md（Opus 4.7 調校）
4. 回報：目前載入的規則摘要 + 待辦事項
```

---

## 6. Opus 4.7 任務規格範本（task-upfront）

> **IMPORTANT**：Opus 4.7 第一輪就要給完整規格，避免多輪補充耗 token。

```
Task: <一句話描述目標>

Why: <商業/技術意圖，為何要做>

Constraints:
- <限制 1，例如不可改動 public API>
- <限制 2，例如必須向後相容>

Acceptance criteria:
- <可驗證的完成條件 1>
- <可驗證的完成條件 2>

Relevant files:
- <file_path:line>
- <file_path:line>

Execution hints:
- Spawn multiple subagents in the same turn when fanning out across files.
- Use xhigh effort (default). Switch to high if token budget is tight.
- Prioritize responding quickly unless a step clearly benefits from deeper thinking.
```

---

## 7. 控制 Opus 4.7 思考量

**要更深入思考**：
```
Think carefully and step-by-step before responding; this problem is harder than it looks.
<你的問題>
```

**要更快回覆**：
```
Prioritize responding quickly rather than thinking deeply. When in doubt, respond directly.
<你的問題>
```

---

## 8. 強制平行 subagent

```
請同時（單一訊息內）啟動多個 subagent 平行處理：
- subagent A: <任務 A>
- subagent B: <任務 B>
- subagent C: <任務 C>

Do not spawn subagents for work you can complete directly in a single response.
完成後合成摘要回報。
```

---

## 9. 走錯路徑時的 Recovery

不要說「那個沒用，試 X」（失敗嘗試仍污染 context）。

改用：
1. 按 `Esc Esc` 或輸入 `/rewind` 跳回上一個正確的分支點
2. 用學到的資訊重新 prompt：
   ```
   別用 A 方法（已驗證 foo module 不提供此功能）。直接走 B 方法，相關檔案是 src/bar.ts。
   ```

或請 Claude 寫 handoff：
```
/rewind
請總結你剛才的探索學到了什麼（什麼路不通、為什麼），以 3-5 句話寫成 handoff message 給「重新開始的自己」。
```

---

## 10. 結束 Session 時

適用於：session 結束前，確保關鍵決策進入 Auto Memory。

```
session 結束前：

1. 用 TodoWrite 檢視未完成項目
2. 執行 /memory 確認關鍵決策已記錄（專案架構、技術選型、上次失敗嘗試）
3. git status + git diff 檢視未提交變更
4. 若有變更：git add → commit → push -u origin <branch>

不要只說「好」— 實際執行每一步並回報結果。
```
