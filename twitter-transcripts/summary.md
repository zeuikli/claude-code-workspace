# 核心摘要：Claude Code 實用技巧演講

**講者**: Boris Cherny（Anthropic Staff，Claude Code 創作者）
**來源**: https://x.com/eng_khairallah1/status/2054211760631185485
**逐字稿**: [transcript.md](./transcript.md)
**原始語言**: 英文 ｜ **整理語言**: 繁體中文

> **⚠️ 辨識備註**: Whisper 將 "Claude Code" 誤辨識為 "Quad Code"（發音相似），本摘要已還原正確名稱。

---

## 一句話總結

> Claude Code 是完全 agentic 的 AI 編碼助手，不是逐行補全工具——從 codebase Q&A 入門、搭配 CLAUDE.md 與 MCP 工具深化、最後用 SDK 與平行 session 解鎖進階工作流。

---

## 目錄

1. [什麼是 Claude Code](#1-什麼是-claude-code)
2. [初次啟動設定](#2-初次啟動設定)
3. [Tip 1：從 Codebase Q&A 開始](#3-tip-1從-codebase-qa-開始)
4. [Tip 2：編輯程式碼的正確姿勢](#4-tip-2編輯程式碼的正確姿勢)
5. [Tip 3：整合團隊工具（Bash + MCP）](#5-tip-3整合團隊工具bash--mcp)
6. [Tip 4：透過 CLAUDE.md 給予更多 Context](#6-tip-4透過-claudemd-給予更多-context)
7. [常用快捷鍵速查](#7-常用快捷鍵速查)
8. [進階：Claude Code SDK（`-p` 旗標）](#8-進階claude-code-sdk-p-旗標)
9. [進階：平行 Session（Power User 模式）](#9-進階平行-sessionpower-user-模式)
10. [Q&A 精華](#10-qa-精華)

---

## 1. 什麼是 Claude Code

| 特性 | 說明 |
|------|------|
| **完全 Agentic** | 不是逐行補全，而是建功能、寫整個函式／檔案、修整個 Bug |
| **不換工作流** | 相容 VS Code、Xcode、JetBrains、Vim、Emacs 等所有 IDE |
| **跨環境** | 本機、遠端 SSH、Tmux 均可使用 |
| **通用工具** | 開放式 prompt bar，你決定用法，不強制特定工作流 |

**時間戳**: `01:16 → 02:17`

---

## 2. 初次啟動設定

```bash
# 安裝（需要 Node.js）
npm install -g @anthropic-ai/claude-code

# 推薦的首次設定指令
/terminal-setup   # 啟用 Shift+Enter 換行（不需 backslash）
/theme            # 設定 light / dark / Daltonized 佈景主題
/install-github-app  # 安裝 GitHub App（在 Issue / PR 中 @Claude）
```

- **允許工具設定**：預先允許常用工具，避免每次都被詢問確認
- **語音輸入**（macOS）：System Settings → Accessibility → Dictation，按兩下 dictation 鍵即可說出 prompt

**時間戳**: `02:47 → 04:00`

---

## 3. Tip 1：從 Codebase Q&A 開始

**最推薦的入門姿勢**，也是 Anthropic 新人 onboarding 的第一步。

### 效果
- 技術 onboarding 從 **2-3 週** 縮短為 **2-3 天**
- 不僅做文字搜尋，會主動深挖：找類別如何被實例化、追 git history 查引入脈絡

### 推薦問法範例

```
# 程式碼理解
How is [ClassName] instantiated in this codebase?
Why does [functionName] have 15 arguments? Look through git history.

# 版本歷史
Who introduced [argument] and what issue was it linked to?

# 每週 standup（Boris 親自使用）
What did I ship this week? (Claude looks at git log + knows your username)

# GitHub Issues
Fetch and summarize issue #[number]  (uses web_fetch tool)
```

### 隱私承諾
- **無遠端資料庫**，程式碼不上傳
- **不用於訓練模型**
- **無需索引**，下載後立即可用

**時間戳**: `04:05 → 07:48`

---

## 4. Tip 2：編輯程式碼的正確姿勢

### 核心工具組合

Claude Code 只給模型三類工具，讓它自行組合：

| 工具 | 用途 |
|------|------|
| Edit files | 修改原始碼 |
| Run bash | 執行指令 |
| Search files | 搜尋 codebase |

### 最佳實踐：先規劃再執行

```
# 不推薦（直接要求大功能）
Implement this 3000-line feature.

# 推薦（先讓它規劃）
Before writing code, brainstorm ideas and make a plan. Run it by me for approval first.
```

### 推薦的 commit 指令模式

```
Implement [feature], then commit, push for this.
```
Claude 會自動看 git log 找出 commit 格式、建立 branch 並開 PR——**不需要任何額外提示**。

### 迭代工作流（最強模式）

給 Claude **驗證工具**，讓它自我迭代：
- 前端：Puppeteer screenshot → 對比 mock 圖
- App：iOS Simulator screenshot
- 後端：Unit tests / integration tests

> 訣竅：給它看結果的方式，它就能自己迭代到接近完美。

**時間戳**: `07:48 → 11:51`

---

## 5. Tip 3：整合團隊工具（Bash + MCP）

```bash
# 告訴 Claude 你的自訂 CLI
Use our internal CLI `burly`. Run `burly --help` to understand how to use it.

# 加入 MCP 工具
Add the [tool-name] MCP server and use it for [purpose].
```

- 常用工具可寫入 `CLAUDE.md` 讓 Claude 跨 session 記住
- Anthropic apps repo 範例：共享 **Puppeteer MCP server**，`mcp.json` commit 進 repo，團隊每人自動可用

**時間戳**: `09:47 → 10:52`

---

## 6. Tip 4：透過 CLAUDE.md 給予更多 Context

### CLAUDE.md 層級架構

```
企業 Policy CLAUDE.md          ← 全員共享，不可 override
└── ~/CLAUDE.md                ← 個人全域設定
    └── [project]/CLAUDE.md   ← 專案共享（commit 進 repo）
        └── [subdir]/CLAUDE.md ← 子目錄按需載入
```

### 放什麼內容

- 常用 bash 指令
- 常用 MCP 工具說明
- 架構決策記錄
- 重要檔案路徑
- Style guide
- **保持簡短**：太長會佔 context window 且效果遞減

### Slash Commands

位置：`~/.claude/commands/` 或專案內 `.claude/commands/`

```bash
/label-github-issues    # Anthropic 內部用來自動標記 Issue 的 slash command
```

### 企業層級管控

```json
// 企業 policy（員工無法 override）
{
  "allow": ["npm test", "make build"],   // 自動核准
  "deny": ["curl https://internal.io"]   // 永久封鎖
}
```

### 管理指令

```bash
/memory    # 查看並編輯所有載入中的 memory 檔案
# + 記憶快捷鍵 → 輸入 # 告訴 Claude 要記住什麼，它會自動寫入 CLAUDE.md
```

**時間戳**: `12:02 → 18:00`

---

## 7. 常用快捷鍵速查

| 快捷鍵 | 功能 |
|--------|------|
| `Shift+Tab` | 切換「自動接受編輯」模式（bash 仍需確認） |
| `#` | 請 Claude 記住某件事，自動寫入 CLAUDE.md |
| `!` | 直接執行 bash 指令（結果也進 context window） |
| `Escape` | 停止目前操作（不會中斷 session） |
| `Escape × 2` | 跳回歷史紀錄 |
| `Ctrl+R` | 顯示完整輸出（Claude 的完整 context） |
| `claude --resume` | 恢復上次 session |
| `claude --continue` | 繼續上次 session |

**時間戳**: `18:10 → 20:44`

---

## 8. 進階：Claude Code SDK（`-p` 旗標）

```bash
# 基本用法
claude -p "Your prompt here" \
  --allowedTools "Bash(npm:*),Read,Edit" \
  --output-format json

# 管道組合（Unix 哲學）
git status | claude -p "Summarize what changed" | jq '.result'

# CI / 事故回應 / 自動化 pipeline
cat error.log | claude -p "What's interesting in this log?" --output-format json
```

- 可視為「超級智慧的 Unix utility」—— 接受任何輸入，輸出 JSON
- Anthropic 內部用於：CI pipeline、incident response、自動化任務
- 支援 streaming JSON（`--output-format streaming-json`）

**時間戳**: `20:44 → 22:33`

---

## 9. 進階：平行 Session（Power User 模式）

Power user 常見設定：

```bash
# 多個 repo 的獨立 checkout，各自跑一個 Claude
git worktree add ../my-repo-feat-a feature-a
git worktree add ../my-repo-feat-b feature-b
claude  # 在 feat-a 目錄
claude  # 在 feat-b 目錄

# SSH + Tmux 遠端存取
tmux new-session -d -s claude1
ssh remote-box -t "tmux attach -t claude1"
```

> Boris 自稱「Claude normie」——通常只開一個，但看到真正的 power user 都是多 SSH + Tmux + 多 worktree 並行。

**時間戳**: `22:33 → 23:29`

---

## 10. Q&A 精華

### Q: 建置最困難的部分？

**A（Boris）**: Bash 安全性。Bash 本質上危險，但如果每個指令都要手動批准又很煩。

解法：
1. 靜態分析辨識「唯讀指令」
2. 分析哪些指令組合是安全的
3. 多層次權限系統（allow / deny at different levels）

### Q: Claude Code 支援多模態嗎？

**A**: 完全支援，從一開始就有。可以：
- 直接拖曳圖片進終端
- 給圖片路徑
- 複製貼上截圖

Boris 常用法：拖入 UI mock → 要求實作 → 給 dev server 讓它截圖迭代

### Q: 為什麼選 CLI 而不是 IDE 外掛？

**A**: 兩個原因：
1. **通用性**：Anthropic 內部大家 IDE 都不同，terminal 是最小公分母
2. **前瞻性**：「到今年底，大家可能不再用 IDE 了」——模型進步速度讓 UI 層的投資報酬率下降

### Q: Anthropic 自己如何使用？

**A**: ~80% 的技術人員每天使用，包含 ML 研究員（使用 Notebook tool 跑實驗）

---

## 技術選型小結

| 層級 | 工具 | 用途 |
|------|------|------|
| 入門 | Codebase Q&A | 學習 codebase、onboarding |
| 基礎 | Edit + Bash + Search | 主要編碼工作流 |
| 中階 | Bash tools + MCP | 整合團隊特有工具 |
| 進階 | CLAUDE.md 階層 | 跨 session 記憶與團隊共享 |
| 高階 | SDK `-p` flag | CI/CD、自動化 pipeline |
| 極致 | 多 worktree 平行 | 同時推進多個功能分支 |

---

*本摘要由 Claude Code 根據 Whisper 逐字稿整理生成。引用請注明來源推文。*
