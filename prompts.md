# 萬用 Prompt 集

> 複製貼上即可使用，適用於任何 Claude Code session。

---

## 1. 標準開場（推薦）

適用於：任何新 session 的第一句話。支援本機（`~/`）與雲端（`/tmp/`）自動偵測。

```
請執行：DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; command -v git >/dev/null 2>&1 && (([ -d "$DIR/.git" ] && git -C "$DIR" pull -q origin main || (rm -rf "$DIR" 2>/dev/null; git clone --depth 1 -q https://github.com/zeuikli/claude-code-workspace.git "$DIR")) && mkdir -p ~/.claude && printf "@${DIR}/CLAUDE.md\n@${DIR}/Memory.md\n" > ~/.claude/CLAUDE.md)

完成後依序讀取並遵循：
1. ${DIR}/CLAUDE.md（專案指令與規則）
2. ${DIR}/Memory.md（對話記憶，恢復上下文）
```

---

## 2. 極簡版（一行）

適用於：已確認 Hook 自動載入的 session，只需驗證。

```
請確認已載入 claude-code-workspace 的 CLAUDE.md 和 Memory.md，列出目前的指令規則摘要。
```

---

## 3. 接續上次工作

適用於：延續前一個 session 的開發。

```
請載入 workspace 設定後，讀取 Memory.md 確認上次的工作進度，接續未完成的項目。如果有待辦事項，用 TodoWrite 列出並開始執行。
```

---

## 4. 新專案初始化

適用於：第一次在某個專案中設定自動載入。

```
請幫我在這個專案建立 .claude/settings.json，加入 SessionStart Hook 來自動載入我的 workspace 設定：

{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'REPO=https://github.com/zeuikli/claude-code-workspace.git; DIR=/tmp/claude-code-workspace; if [ -d $DIR/.git ]; then git -C $DIR pull -q origin main; else git clone -q --depth 1 $REPO $DIR; fi; mkdir -p ~/.claude; echo \"@${DIR}/CLAUDE.md\" > ~/.claude/CLAUDE.md; echo \"@${DIR}/Memory.md\" >> ~/.claude/CLAUDE.md'"
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
請執行：DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; command -v git >/dev/null 2>&1 && (([ -d "$DIR/.git" ] && git -C "$DIR" pull -q origin main || (rm -rf "$DIR" 2>/dev/null; git clone --depth 1 -q https://github.com/zeuikli/claude-code-workspace.git "$DIR")) && mkdir -p ~/.claude && printf "@${DIR}/CLAUDE.md\n@${DIR}/Memory.md\n" > ~/.claude/CLAUDE.md)

完成後依序讀取並遵循：
1. ${DIR}/CLAUDE.md（專案指令與規則）
2. ${DIR}/Memory.md（對話記憶，恢復上下文）
3. ${DIR}/docs/advisor-strategy.md（Advisor 模式）
4. 回報：目前載入的規則摘要 + 上次工作進度 + 待辦事項
```

---

## 6. 結束 Session 時

適用於：session 結束前，確保記憶保存。

```
請更新 /tmp/claude-code-workspace/Memory.md，記錄本次 session 的：
- 完成事項
- 已修改的檔案清單
- 關鍵決策與技術選型
- 下一步待辦事項
然後 commit 並 push 回 GitHub。
```

---

## 7. Opus 4.7 首輪前置規格（推薦用於複雜任務）

適用於：任何需要 Opus 4.7 處理的多步驟任務。Opus 4.7 在第一輪拿到完整規格時效果最好。

```
任務：[描述你要做什麼]

意圖：[為什麼要做，解決什麼問題]

限制：
- [技術限制 1，例如：不能修改 public API]
- [環境限制 2，例如：只能用 Node.js 18+]

驗收標準：
- [ ] [可驗證的條件 1]
- [ ] [可驗證的條件 2]

相關檔案：
- src/xxx.ts — [簡述用途]
- docs/yyy.md — [簡述用途]

請一次性規劃並執行，中間不需要我確認。
```

---

## 8. Opus 4.7 平行 Sub Agent 展開（顯式指示）

適用於：需要同時探索多個獨立面向時。Opus 4.7 預設較少自動展開，需明確要求。

```
請同時啟動多個 Sub Agent 平行處理以下獨立任務（不要等一個完成再開始下一個）：

1. [任務 A] — 回傳：[期望的摘要格式]
2. [任務 B] — 回傳：[期望的摘要格式]
3. [任務 C] — 回傳：[期望的摘要格式]

各 Sub Agent 只需回傳摘要，不要貼完整檔案內容。
```

---

## 9. Opus 4.7 Auto Mode（長跑任務）

適用於：已提供充足上下文、希望 Opus 4.7 自主執行不打斷的長任務。

```
以下是完整任務規格：[貼上完整說明]

請使用 Auto Mode（如果尚未開啟，按 Shift+Tab 切換）自主執行。
完成後用 hook 通知我（例如播放提示音）。
中間若遇到真正的歧義再暫停，其他情況直接判斷執行。
```

---

## 10. 調整 Opus 4.7 推理深度

適用於：需要精細控制 token 用量與回應速度時。

**要更深思熟慮時：**
```
Think carefully and step-by-step before responding; this problem is harder than it looks.
```

**要更快速直接時：**
```
Prioritize responding quickly rather than thinking deeply. When in doubt, respond directly.
```

**指定努力級別（需在 Claude Code 設定）：**
- `xhigh`（預設）— 適合大多數 coding 任務
- `high` — 平衡成本與智能，適合並行多 session
- `max` — 極限智能，用於 eval 或極複雜研究問題
