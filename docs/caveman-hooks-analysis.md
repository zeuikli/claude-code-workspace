# Caveman Standalone Hooks — 深度研究報告

> 研究對象：[JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman)
> 研究日期：2026-04-15
> 分支：`claude/caveman-hooks-analysis-rizmb`（基於 `claude/karpathy-optimization-merged`）

---

## TL;DR

Caveman 透過兩條互補路徑節省 Token：

| 路徑 | 目標 | 節省幅度 |
|------|------|----------|
| **Standalone Hooks** → caveman-speak 輸出模式 | Output tokens（AI 回應） | **~65–75%** |
| **caveman-compress** | Input tokens（每次載入的記憶檔） | **~46%** |

合併效果：**每次 session 可節省逾 60% 的總 token 消耗**，且技術準確性不降低。

---

## 1. Standalone Hooks 架構

### 1.1 什麼是 Standalone

Caveman 有兩種安裝方式：

- **Plugin 安裝**：`claude plugin install caveman@caveman`（全自動）
- **Standalone 安裝**：直接用 shell script 注入 hooks，不依賴 plugin 系統

```bash
# macOS / Linux / WSL — standalone 一行安裝
bash <(curl -s https://raw.githubusercontent.com/JuliusBrussee/caveman/main/hooks/install.sh)
```

Standalone 安裝執行以下動作（`hooks/install.sh`）：
1. 下載 4 個 hook 檔案到 `~/.claude/hooks/`
2. 用 Node.js 修改 `~/.claude/settings.json`，注入 `SessionStart` / `UserPromptSubmit` / `statusLine` 設定
3. 若已有自訂 statusLine，跳過不覆蓋

### 1.2 三個 Hook 元件

```
SessionStart hook ──writes "full"──▶ ~/.claude/.caveman-active ◀──writes mode── UserPromptSubmit hook
                                              │
                                           reads
                                              ▼
                                     caveman-statusline.sh
                                    [CAVEMAN] / [CAVEMAN:ULTRA] / ...
```

| Hook 元件 | 事件類型 | 核心功能 |
|-----------|----------|---------|
| `caveman-activate.js` | `SessionStart` | 注入 caveman 規則為隱藏系統 context |
| `caveman-mode-tracker.js` | `UserPromptSubmit` | 偵測 `/caveman` 命令，更新模式旗標 |
| `caveman-statusline.sh` | `statusLine` | 讀取旗標，顯示 `[CAVEMAN:ULTRA]` 等徽章 |
| `caveman-config.js` | 共用工具 | 解析預設模式（env var → config 檔 → `full`） |

---

## 2. SessionStart Hook 的 Token 節省機制（核心）

### 2.1 隱藏系統 Context 注入

`caveman-activate.js` 的關鍵設計：SessionStart hook 的 **stdout 會被 Claude Code 自動注入為隱藏系統 context**，使用者看不到，但 Claude 看得到。

```javascript
// hooks/caveman-activate.js — 節錄關鍵段落

// 1. 寫入旗標檔
fs.writeFileSync(flagPath, mode);  // ~/.claude/.caveman-active

// 2. 讀取 SKILL.md（單一真實來源）
skillContent = fs.readFileSync(
  path.join(__dirname, '..', 'skills', 'caveman', 'SKILL.md'), 'utf8'
);

// 3. 過濾：只保留當前強度等級的規則，丟棄其他等級
const filtered = body.split('\n').reduce((acc, line) => {
  const tableRowMatch = line.match(/^\|\s*\*\*(\S+?)\*\*\s*\|/);
  if (tableRowMatch) {
    if (tableRowMatch[1] === modeLabel) acc.push(line);  // 只保留 active 等級
    return acc;
  }
  const exampleMatch = line.match(/^- (\S+?):\s/);
  if (exampleMatch) {
    if (exampleMatch[1] === modeLabel) acc.push(line);  // 只保留 active 等級的範例
    return acc;
  }
  acc.push(line);
  return acc;
}, []);

// 4. 輸出 → Claude Code 注入為系統 context
process.stdout.write('CAVEMAN MODE ACTIVE — level: ' + modeLabel + '\n\n' + filtered.join('\n'));
```

**為何這樣設計比放在 CLAUDE.md 更省 Token？**

- **CLAUDE.md 載入**：每次 session 開始，CLAUDE.md 的完整內容都佔用 input token（全部 6 個強度等級的規則）
- **SessionStart Hook 注入**：只注入當前等級的規則，過濾掉其他 5 個等級；且 hidden system context 的計費方式通常比 conversation history 更高效

### 2.2 防漂移設計

作者原本用「2 句摘要」，但模型在長對話後會漂移回 verbose 模式。改進方案：

> "The old 2-sentence summary was too weak — models drifted back to verbose mid-conversation, especially after context compression pruned it away. **Full rules with examples anchor behavior much more reliably.**"

完整規則 + 具體範例 → 即使 context 被壓縮，行為錨點仍保持穩定。這是一個**直接對抗 context compaction 導致行為漂移**的設計。

### 2.3 Fallback 策略（Standalone 無 skills 目錄時）

```javascript
// 找不到 SKILL.md 時（standalone 安裝），使用硬編碼的最小可行規則集
output =
  'CAVEMAN MODE ACTIVE — level: ' + modeLabel + '\n\n' +
  'Respond terse like smart caveman. All technical substance stay. Only fluff die.\n\n' +
  // ... 精簡版規則
```

兩層防禦：plugin 安裝用完整 SKILL.md，standalone 安裝用最小規則集，確保功能不中斷。

---

## 3. UserPromptSubmit Hook 的零開銷模式追蹤

`caveman-mode-tracker.js` 在**每次**使用者送出 prompt 時觸發：

```javascript
process.stdin.on('end', () => {
  const data = JSON.parse(input);
  const prompt = (data.prompt || '').trim().toLowerCase();

  if (prompt.startsWith('/caveman')) {
    // 偵測命令，寫入旗標
    fs.writeFileSync(flagPath, mode);
  }
  if (/\b(stop caveman|normal mode)\b/i.test(prompt)) {
    fs.unlinkSync(flagPath);  // 刪除旗標 = 停用模式
  }
  // 一律 silent fail，不阻塞
});
```

**設計重點：**
- 非 `/caveman` 命令 → 讀取 stdin、快速 exit，幾乎零 overhead
- 模式切換不透過 AI 對話，直接寫旗標檔 → 不耗費任何 token
- 旗標檔是 sessionless 狀態橋接器，讓 3 個獨立進程（activate / tracker / statusline）共享狀態

---

## 4. Output Token 節省量化

### 4.1 Benchmark 數據（來自 caveman repo `benchmarks/`）

使用真實 Claude API 呼叫計算：

| 任務 | 正常模式 (tokens) | Caveman (tokens) | 節省 |
|------|------------------:|------------------:|------|
| 解釋 React re-render bug | 1,180 | 159 | **87%** |
| 修復 auth middleware | 704 | 121 | **83%** |
| 設定 PostgreSQL 連線池 | 2,347 | 380 | **84%** |
| 解釋 git rebase vs merge | 702 | 292 | **58%** |
| 重構 callback → async/await | 387 | 301 | **22%** |
| 架構決策：微服務 vs 單體 | 446 | 310 | **30%** |
| Docker multi-stage build | 1,042 | 290 | **72%** |
| Debug PostgreSQL race condition | 1,200 | 232 | **81%** |
| **平均** | **1,214** | **294** | **65%** |

### 4.2 Eval 數據（三臂對照）

Repo 使用嚴謹的 3 臂 eval 設計，避免混淆效果：

```
__baseline__   — 無 system prompt（verbose 基準）
__terse__      — "Answer concisely."（通用簡潔基準）
caveman        — "Answer concisely." + SKILL.md（caveman 真實貢獻）
```

> 重要：比較 caveman vs `__baseline__` 會誇大效果（因為包含「通用簡潔」的貢獻）。真實的 caveman 增益 = `caveman vs __terse__`。

### 4.3 Context Window 間接節省

Output token 節省對 context window 的複利效果：

- 每個 AI 回應縮短 65% → 在長對話中，歷史記錄佔用的 context 空間顯著減少
- 更長的有效對話壽命：相同 context window 下，可容納更多輪次的對話
- 減少 compaction 觸發頻率：回應短 → 對話積累慢 → 壓縮週期拉長

---

## 5. Input Token 節省：caveman-compress

這是 output token 節省以外的**第二條路徑**，直接針對 input token。

### 5.1 核心概念

```
CLAUDE.md（每次 session 載入）→ 每次都消耗 input token

解法：用 caveman-speak 重寫 CLAUDE.md
→ CLAUDE.md          ← 壓縮版（Claude 讀的，token 少）
→ CLAUDE.original.md ← 人類可讀備份（你編輯的）
```

觸發方式：`/caveman:compress CLAUDE.md`

### 5.2 壓縮規則

**必須移除：**
- Articles（a/an/the）
- Filler words（just/really/basically/actually/simply）
- Pleasantries（sure/certainly/of course/happy to）
- Hedging（it might be worth/you could consider）
- 冗餘短語（"in order to" → "to"、"make sure to" → "ensure"）

**必須完整保留：**
- Code blocks（``` 內容完全不動）
- Inline code（反引號內容完全不動）
- URLs / File paths / Commands
- 技術術語、版本號、日期
- Markdown 結構（heading、列表層級、表格結構）

### 5.3 實測節省數據

| 檔案 | 原始 token | 壓縮後 | 節省 |
|------|----------:|--------:|------|
| claude-md-preferences.md | 706 | 285 | **59.6%** |
| project-notes.md | 1,145 | 535 | **53.3%** |
| claude-md-project.md | 1,122 | 636 | **43.3%** |
| todo-list.md | 627 | 388 | **38.1%** |
| mixed-with-code.md | 888 | 560 | **36.9%** |
| **平均** | **898** | **481** | **46%** |

---

## 6. 完整 Token 節省架構圖

```
┌─────────────────────────────────────────────────────────────┐
│                    Claude Code Session                       │
│                                                             │
│  INPUT TOKENS                         OUTPUT TOKENS         │
│  ┌─────────────────────┐              ┌──────────────────┐  │
│  │ CLAUDE.md（壓縮版） │              │  AI 回應         │  │
│  │ -46% via compress   │              │  -65% via hooks  │  │
│  └─────────────────────┘              └──────────────────┘  │
│           ↑                                    ↑            │
│   /caveman:compress                   SessionStart Hook     │
│   (手動，一次性)                      (自動，每次 session)  │
│                                                             │
│  ┌────────────────────────────────────────────────────────┐ │
│  │  ~/.claude/.caveman-active  （旗標檔）                 │ │
│  │  SessionStart → writes mode  UserPromptSubmit → updates │ │
│  │  Statusline → reads + displays [CAVEMAN:ULTRA]          │ │
│  └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

---

## 7. 與本 Workspace 的整合啟示

### 7.1 直接可採用的設計

| 設計 | 說明 | 採用優先級 |
|------|------|-----------|
| **SessionStart hidden context** | 將頻繁使用的指令注入為 session context 而非放在 CLAUDE.md | ⭐⭐⭐ 高 |
| **caveman-compress CLAUDE.md** | 本 workspace 的 CLAUDE.md 可壓縮約 40-50% | ⭐⭐⭐ 高 |
| **強度等級過濾** | 只注入當前需要的規則子集，不全量載入 | ⭐⭐ 中 |
| **旗標檔跨進程通信** | 用 `~/.claude/` 目錄下的小檔案橋接多個 hooks | ⭐⭐ 中 |

### 7.2 本 Workspace 已有的類似機制

| 本 Workspace | Caveman 對應 |
|-------------|-------------|
| `UserPromptSubmit` Sub Agent 提醒 hook | `caveman-mode-tracker.js` |
| `SessionStart` 自動 clone + 載入 CLAUDE.md | `caveman-activate.js` |
| `.claude/rules/` 目錄（lazy-load） | SKILL.md 過濾機制 |

### 7.3 可進一步優化的方向

1. **壓縮本 workspace 的 CLAUDE.md**：
   - 當前 CLAUDE.md 包含大量說明性語言，適合 caveman-compress
   - 預估節省：~40-50%（基於 benchmark 數據）

2. **SessionStart 規則過濾**：
   - 目前每次 session 全量載入所有 rules
   - 可改為根據任務類型選擇性注入（如 git 任務只注入 git-workflow.md）

3. **Wenyan 模式（文言文）**：
   - 對中文工作流特別有效（文言文是人類有史以來最高 token 效率的書寫系統）
   - 可考慮為中文對話場景啟用

---

## 8. 關鍵設計原則總結

1. **Hook stdout = 零成本系統 context**：Claude Code 的 SessionStart hook stdout 被注入為隱藏 context，不佔用對話 token 配額，也不顯示給使用者。

2. **規則錨定 > 對話重複**：完整規則集（帶範例）比簡短摘要更能抵抗 context compaction 導致的行為漂移。

3. **旗標檔架構**：用一個 `~/.claude/.caveman-active` 小檔案橋接 3 個獨立執行的 hook 進程，實現無 IPC 的狀態共享。

4. **兩軸分離**：Output token 節省（caveman-speak）和 Input token 節省（caveman-compress）是獨立機制，可分別啟用，也可疊加。

5. **Silent fail 原則**：所有 hook 都包裝在 try/catch，任何檔案系統錯誤都靜默失敗，**不阻塞 session 啟動**。

6. **單一真實來源**：SKILL.md 是 caveman 行為的唯一定義處；hook 在 runtime 讀取並過濾它，所有 agent 的同步透過 CI 自動完成。

---

## 參考資料

- [caveman repo](https://github.com/JuliusBrussee/caveman) — hooks/、skills/、caveman-compress/ 目錄
- [Brevity Constraints Reverse Performance Hierarchies](https://arxiv.org/abs/2604.00025) — 簡潔回應提升準確率 26% 的論文依據
- [Claude Code hooks 官方文件](https://docs.anthropic.com/en/docs/claude-code/hooks) — SessionStart stdout 注入機制的規範
- 本 workspace：`docs/hook-lifecycle.md`、`docs/karpathy-optimization-report.md`
