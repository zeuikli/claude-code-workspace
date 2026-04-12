# Claude Code Workspace

針對 [Claude Code](https://code.claude.com) 優化的個人開發工作區，內建專案指令、對話記憶管理與自動化工作流程配置。

## 專案概述

本專案作為 Claude Code 的工作環境，透過精心設計的 `CLAUDE.md` 指令檔，實現：

- **雙語自動回覆** — 中文對話回覆台灣繁體中文，英文對話回覆英文
- **Sub Agent 優先策略** — 自動分派子代理處理任務，保持主對話 context 精簡
- **Context Window 智慧管理** — 接近 70% 使用量時自動提醒，搭配 Memory.md 跨對話記憶
- **Git 自動化工作流程** — 改動完成後自動 push、merge，並按需更新文件

## 檔案結構

```
claude-code-workspace/
├── CLAUDE.md        # Claude Code 專案指令（每次對話自動載入）
├── Memory.md        # 跨對話記憶摘要（上下文保存與恢復）
├── CHANGELOG.md     # 專案變更紀錄
└── README.md        # 本文件
```

## 核心配置說明

### CLAUDE.md

依據 [Claude Code 官方最佳實踐](https://code.claude.com/docs/en/best-practices) 撰寫，包含：

| 區塊 | 用途 |
|------|------|
| 語言規則 | 依使用者語言自動切換回覆語系 |
| Sub Agent 策略 | 分派主 Agent 協調任務，委派 Sub Agent 執行調查 |
| Context Window 管理 | 70% 預警、Memory.md 摘要、compaction 指引 |
| Git 工作流程 | 完整的 commit → push → merge 流程與重試機制 |
| 驗證與品質 | 測試優先、lint 檢查、UI 截圖比對 |

### Memory.md

記錄每次對話的工作進度、已修改檔案、關鍵決策與下一步待辦，確保跨對話無縫接續。

### CHANGELOG.md

追蹤所有專案變更，格式為日期 + 分類（新增 / 優化 / 修復）+ 變更摘要。

## 使用方式

1. **Clone 此 repo**
   ```bash
   git clone https://github.com/zeuikli/claude-code-workspace.git
   cd claude-code-workspace
   ```

2. **啟動 Claude Code**
   ```bash
   claude
   ```
   Claude Code 會自動讀取 `CLAUDE.md`，套用所有專案指令。

3. **開始工作** — 直接用中文或英文下達指令即可。

## 自訂與擴展

- 編輯 `CLAUDE.md` 加入你的專案特定規則（建議保持精簡）
- 在 `.claude/skills/` 建立 Skill 檔案，擴展特定領域知識
- 在 `.claude/agents/` 建立自訂 Sub Agent，處理專門任務
- 透過 `.claude/settings.json` 設定 Hooks，實現自動化動作

## 授權

MIT License
