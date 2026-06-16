# 萬用 Prompt 集

> 常用 3 條開場／結束 prompt。

---

## 1. 標準開場（推薦）

```
請 clone 這個 repo：git clone https://github.com/zeuikli/claude-code-workspace.git

完成後讀取並遵循 claude-code-workspace/CLAUDE.md。跨對話記憶由官方 Auto Memory 自動管理。
```

---

## 2. 極簡版

```
請確認已載入 workspace 的 CLAUDE.md，列出目前的指令規則摘要，
並覆述 The Loop 六階段（OBSERVE → IDENTIFY → PROPOSE → APPLY → TEST → RECORD）作為載入驗證。
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

> 進階模板（接續工作、新專案初始化、平行 subagent、Prompt Caching 最大化）可依需求自行擴充。
