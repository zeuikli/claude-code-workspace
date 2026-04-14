# 萬用 Prompt 集

> 複製貼上即可使用，適用於任何 Claude Code session。

---

## 1. 標準開場（推薦）

適用於：任何新 session 的第一句話。**自動偵測本機/雲端環境**。

```
請執行：DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; command -v git >/dev/null 2>&1 && (([ -d "$DIR/.git" ] && git -C "$DIR" pull -q origin main || (rm -rf "$DIR" 2>/dev/null; git clone --depth 1 -q https://github.com/zeuikli/claude-code-workspace.git "$DIR")) && mkdir -p ~/.claude && printf "@${DIR}/CLAUDE.md\n@${DIR}/Memory.md\n" > ~/.claude/CLAUDE.md)

完成後依序讀取並遵循：
1. ${DIR}/CLAUDE.md（專案指令與規則）
2. ${DIR}/Memory.md（對話記憶，恢復上下文）
```

---

## 2. 極簡版（一行）

適用於：已確認 Hook 自動載入的 session，只需驗證。**自動偵測環境**。

```
請執行 DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; ls -la "$DIR"，確認已載入 claude-code-workspace 並列出目前的指令規則摘要。
```

---

## 3. 接續上次工作

適用於：延續前一個 session 的開發。**自動偵測環境**。

```
請執行：DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; command -v git >/dev/null 2>&1 && (([ -d "$DIR/.git" ] && git -C "$DIR" pull -q origin main || git clone --depth 1 -q https://github.com/zeuikli/claude-code-workspace.git "$DIR"))

然後讀取 ${DIR}/Memory.md 確認上次的工作進度，接續未完成的項目。如果有待辦事項，用 TodoWrite 列出並開始執行。
```

---

## 4. 新專案初始化（簡化版）

> 📝 **注意**：實務上直接複製 `.claude/settings.json` 的 `SessionStart` hook 即可，範例見 [README.md](README.md)。本 Prompt 僅作參考。

```
請幫這個專案建立 .claude/settings.json，複製 zeuikli/claude-code-workspace 的 SessionStart hook 設定並 push。
```

---

## 5. 完整載入（含 Advisor 策略）

適用於：需要完整載入所有設定與參考文件的複雜任務。

```
請先載入我的 workspace 設定：
1. 執行 `git clone --depth 1 https://github.com/zeuikli/claude-code-workspace.git /tmp/claude-code-workspace 2>/dev/null || git -C /tmp/claude-code-workspace pull -q origin main`
2. 讀取並遵循 /tmp/claude-code-workspace/CLAUDE.md 的所有指令
3. 讀取 /tmp/claude-code-workspace/Memory.md 確認上次進度
4. 讀取 /tmp/claude-code-workspace/docs/advisor-strategy.md 了解 Advisor 模式
5. 回報：目前載入的規則摘要 + 上次工作進度 + 待辦事項
```

---

## 6. 結束 Session 時（已自動化，保留作手動觸發）

> 📝 **注意**：`Stop` hook + `memory-update-hook.sh` 已自動處理 Memory.md commit/push。本 Prompt 僅用於手動補記。

```
請更新 Memory.md 紀錄本次 session：完成事項、修改檔案、關鍵決策、待辦事項。Hook 會自動 push。
```
