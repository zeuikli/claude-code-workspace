# 進階 Prompt 集（Advanced）

> Lazy-load：需要特定場景時再載入。核心 3 條見 `prompts.md`。

---

## A. 接續上次工作

```
請載入 workspace 設定，執行 /memory 查看 Auto Memory 中上次的工作進度，接續未完成的項目。如果有待辦事項，用 TodoWrite 列出並開始執行。
```

---

## B. 新專案初始化（含 Opus 4.7 設定）

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
            "command": "bash -c 'DIR=/tmp/claude-code-workspace; [ -d \"$DIR/.git\" ] && git -C \"$DIR\" pull -q origin main || git clone -q --depth 1 https://github.com/zeuikli/claude-code-workspace.git \"$DIR\"; mkdir -p ~/.claude; echo \"@${DIR}/CLAUDE.md\" > ~/.claude/CLAUDE.md'"
          }
        ]
      }
    ]
  }
}

設定完成後 commit 並 push。
```

---

## C. 完整載入（含 Advisor 策略）

```
請執行標準開場後依序讀取：
1. ${DIR}/CLAUDE.md
2. ${DIR}/docs/advisor-strategy.md
3. ${DIR}/.claude/rules/opus47-best-practices.md
4. 回報：目前載入的規則摘要 + 待辦事項
```

---

## D. Opus 4.7 任務規格範本（task-upfront）

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

## E. 控制 Opus 4.7 思考量

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

## F. 強制平行 Subagent

```
請同時（單一訊息內）啟動多個 subagent 平行處理：
- subagent A: <任務 A>
- subagent B: <任務 B>
- subagent C: <任務 C>

Do not spawn subagents for work you can complete directly in a single response.
完成後合成摘要回報。
```

---

## G. 走錯路徑時的 Recovery

不要說「那個沒用，試 X」（失敗嘗試仍污染 context）。改用：

1. 按 `Esc Esc` 或輸入 `/rewind` 跳回上一個正確分支點
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

## H. Auto Mode（長跑任務，Claude Code Max 限定）

```
以下是完整任務規格：[貼上完整說明]

請使用 Auto Mode（若尚未開啟，按 Shift+Tab 切換）自主執行。
完成後請建立 hook 發出音效提示（例如：`afplay /System/Library/Sounds/Glass.aiff`）。
中間若遇到真正的歧義再暫停，其他情況直接判斷執行。
```

Stop Hook 音效範例（寫入 `.claude/settings.json`）：

```json
"Stop": [
  { "matcher": "", "hooks": [{ "type": "command",
    "command": "afplay /System/Library/Sounds/Glass.aiff 2>/dev/null || printf '\\a'" }] }
]
```

---

## I. Prompt Caching 最大化（API / 長 session）

```
請依「靜態優先、動態最後」原則重排 prompt：
1. 系統提示 / 工具定義（最穩定）放最前
2. 長期背景文件（專案規格、API schema）放第二層
3. 對話歷史 / user message 放最後
4. 需要局部更新時，用 <system-reminder> 附加到 messages，不要改動上層穩定區塊

目標：cache breakpoint 設在第 3 層前，前兩層完全重用。
```

> 驗證方式見 `docs/prompt-caching-verification.md`。
