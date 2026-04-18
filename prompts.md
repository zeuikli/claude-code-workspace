# 萬用 Prompt 集（Core）

> 常用 3 條開場／結束 prompt。進階模板見 `docs/prompts-advanced.md`。

---

## 1. 標準開場（推薦）

```
請執行：DIR="${CLAUDE_CODE_REMOTE:+/tmp/claude-code-workspace}"; DIR="${DIR:-$HOME/claude-code-workspace}"; command -v git >/dev/null 2>&1 && (([ -d "$DIR/.git" ] && git -C "$DIR" pull -q origin main || (rm -rf "$DIR" 2>/dev/null; git clone --depth 1 -q https://github.com/zeuikli/claude-code-workspace.git "$DIR")) && mkdir -p ~/.claude && printf "@${DIR}/CLAUDE.md\n" > ~/.claude/CLAUDE.md)

完成後讀取並遵循 ${DIR}/CLAUDE.md。跨對話記憶由官方 Auto Memory 自動管理。
```

---

## 2. 極簡版

```
請確認已載入 claude-code-workspace 的 CLAUDE.md，列出目前的指令規則摘要。
```

---

## 3. 結束 Session

```
session 結束前：
1. 用 TodoWrite 檢視未完成項目
2. 執行 /memory 確認關鍵決策已記錄
3. git status + git diff 檢視未提交變更
4. 若有變更：git add → commit → push -u origin <branch>

不要只說「好」— 實際執行每一步並回報結果。
```

---

> 進階：接續工作、新專案初始化、Opus 4.7 task-upfront、平行 subagent、Auto Mode、Prompt Caching 最大化等見 `docs/prompts-advanced.md`。
