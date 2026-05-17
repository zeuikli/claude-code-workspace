# Claude Code 各面向最佳實踐完整研究報告

**日期**：2026-05-16  
**來源**：`research/best-practices/`（29 篇）+ `research/claude-blog/`（52 篇）  
**目標字數**：≥ 10,000 中文字  
**驗證**：autoresearch + research-hub 三方確認

---

## 執行摘要

Claude Code 已從「AI 輔助編程工具」演進為完整的「開發者作業系統」。本報告基於 Anthropic 官方文件、社群實踐（Boris Cherny、Thariq Shihipar 等核心貢獻者），以及 52 篇官方 claude-blog 文章，系統梳理 Claude Code 在以下九個面向的最佳實踐：

1. CLAUDE.md 與記憶系統設計
2. Hooks 自動化架構
3. Prompt Caching 與 Context 工程
4. Subagent 委派策略
5. Skill 知識封裝與生命週期
6. MCP 整合與工具擴展
7. 安全部署與權限控制
8. Routines 排程自動化
9. 成本工程與效能優化

核心論點：**Context Engineering（在執行時組裝正確資訊並正確排序）是 Claude Code 真正的工程護城河，遠比 Prompt 撰寫技巧更重要。**

---

## 第一章：CLAUDE.md 與記憶系統

### 1.1 CLAUDE.md 設計原則

CLAUDE.md 是 Claude Code 的靈魂文件，每次 session 自動載入。但大多數開發者都犯了同一個錯誤：把它寫得太長、太詳細，反而降低模型遵從率。

**黃金法則**：CLAUDE.md 長度 ≤ 200 行，最佳 60 行。研究數據顯示，超過 200 行後，模型對規則的遵從率從 76% 跌至 52%。

每行都應通過這個問題的測試：「如果移除這行，Claude 會犯錯嗎？」答案是否 → 立即刪除。

**應該寫什麼：**

- Claude 無法從程式碼猜測的 bash 指令（如 `npm run test:unit --reporter=verbose`）
- 與語言預設不同的 code style（如「強制使用 ES modules，禁止 CommonJS」）
- 測試執行方式與偏好的 test runner
- Branch 命名與 PR 慣例
- 專案特定的架構邊界（如「業務邏輯只放 `src/services/`，不放 routes/`」）
- 開發環境特殊性（必要的環境變數、工具依賴）
- 常見陷阱與非直覺行為

**不應該寫什麼：**

- Claude 讀程式碼就能知道的事（框架版本、目錄結構）
- 標準語言慣例（PEP8、ESLint 推薦規則）
- 詳細 API 文件（放連結即可）
- 頻繁變更的資訊（放 `<system-reminder>` 或讓 hook 動態注入）

```markdown
# CLAUDE.md 最簡範本

## 指令
- 測試：`npm run test:unit -- --reporter=verbose`
- 型別檢查：`npm run typecheck`
- 格式化：`npm run format`（提交前必跑）

## 架構約束
- API 路由：`src/routes/`（只放路由定義）
- 業務邏輯：`src/services/`（禁止在 routes 中寫邏輯）
- 資料庫：`src/repositories/`（所有 DB 操作必須在此）

## 非顯而易見的規則
- `.env.test` 用於測試，但 `.env.local` 覆蓋一切
- 新功能必須寫對應 E2E 測試（`tests/e2e/`）
```

### 1.2 Path-Scoped Rules：按路徑觸發的規則

大型 codebase 不需要巨型 CLAUDE.md，而是要用 path-scoped rules：

```markdown
---
paths:
  - "src/api/**/*.ts"
---

# API 開發規範（只在讀取 API 相關檔案時載入）

- 所有端點必須包含輸入驗證（Zod schema）
- 使用標準錯誤回應格式（`{ error: string, code: string }`）
- 包含 OpenAPI 文件 JSDoc
```

將規則放在 `.claude/rules/` 目錄，只有在 Claude 讀取符合 glob pattern 的檔案時才自動載入，避免不相關規則污染 context。

### 1.3 Auto Memory：Claude 的長期記憶

Auto Memory 是 Claude Code 的自學機制，存放在 `~/.claude/projects/<project>/memory/MEMORY.md`。Claude 會自動判斷值得記住的資訊並寫入。

**關鍵限制**：每次 session 自動載入前 200 行或 25KB（以先到者為準）。超過限制的詳細筆記應移到 topic files（`debugging.md`、`patterns.md`），需要時手動讀取。

**雙層記憶架構（建議）：**

```
Auto Memory（~/.claude/projects/.../ memory/MEMORY.md）
  → 自動寫入，存放 session 間學習成果
  
MEMORY.md（Git 追蹤，workspace 根目錄）
  → 手動維護，存放跨裝置共享的決策與狀態
```

**自我改進觸發（Boris Cherny 方法）**：每次 Claude 犯錯並被糾正後，立即更新 CLAUDE.md 加入防範規則。隨時間累積，CLAUDE.md 成為最有價值的 codebase 知識庫。

### 1.4 大型 Codebase 的三層 Context 架構

Brendan MacLean（MacCoss Lab）用此架構管理 70 萬行 C# codebase，讓 Claude 在兩週內完成原本需一年的功能：

**層一：Context Repository（獨立 Git Repo）**

```
pwiz-ai/ （獨立 repo，跨所有 branch 適用）
├── CLAUDE.md              # 根目錄高層概述
├── docs/
│   ├── architecture.md    # 系統架構說明
│   └── api-contracts.md   # API 約定文件
└── indexes/               # 重要檔案索引（供 Claude 快速定位）
```

**層二：Skills Library（可重用領域知識）**

```
skills/
├── skyline-development/   # 開發工作流
├── version-control/       # Git 慣例
└── debugging/             # 常見除錯模式
```

**層三：MCP Integrations（真實資料接入）**

- 連接自動化測試結果（真實失敗勝於猜測）
- 接入異常報告系統
- 連接支援帖庫（讓 Claude 查到真實用戶問題）

**原則**：「參考不嵌入」——Skills 指向文件而非複製內容，保持輕量。

---

## 第二章：Hooks 自動化架構

### 2.1 Hooks 三層架構

Hooks 是 Claude Code 的自動化引擎，讓你在工具呼叫的生命週期插入自訂邏輯：

```
Event → Matcher Group → Handler
```

**事件種類（25 種）：**

| 類別 | 事件 | 典型用途 |
|------|------|---------|
| Session | SessionStart、SessionEnd、SessionStop | 環境初始化、通知 |
| 工具前後 | PreToolUse、PostToolUse | 防守、驗證 |
| Agentic | SubagentStart、SubagentEnd | 子任務監控 |
| 檔案 | 各種 file events | 語法驗證、格式化 |

**Exit Code 規約（必記）：**

- `0`：成功，繼續執行
- `1`：警告，繼續執行（Claude 看到警告訊息）
- `2`：阻斷，完全停止當前操作

### 2.2 防守型 Hooks（PreToolUse）

PreToolUse 是你的第一道防線，在 Claude 執行任何工具前攔截：

```bash
#!/usr/bin/env bash
# ~/.claude/hooks/block-dangerous.sh
set -euo pipefail

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# 阻斷危險命令
BLOCKED_PATTERNS=(
  "rm -rf /"
  "DROP TABLE"
  "TRUNCATE TABLE"
  "terraform destroy"
  "git push --force.*main"
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qiE "$pattern"; then
    echo "⛔ Blocked: 偵測到危險操作 '$pattern'" >&2
    exit 2
  fi
done

# 生產環境警告
if echo "$COMMAND" | grep -q "prod\|production"; then
  echo "⚠️ Warning: 此操作涉及生產環境，請確認" >&2
  exit 1
fi

exit 0
```

**settings.json 配置：**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/block-dangerous.sh"
          }
        ]
      }
    ]
  }
}
```

### 2.3 自動化型 Hooks（PostToolUse）

PostToolUse 讓你在每次工具呼叫後自動執行品質保證：

```bash
#!/usr/bin/env bash
# ~/.claude/hooks/auto-format.sh
# 每次 Edit/Write 後自動格式化

set -uo pipefail

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

if [[ -z "$FILE" ]]; then
  exit 0
fi

# 依檔案類型選擇格式化工具
case "$FILE" in
  *.ts|*.tsx|*.js|*.jsx)
    npx prettier --write "$FILE" 2>/dev/null && echo "✅ Formatted: $FILE"
    ;;
  *.py)
    black "$FILE" 2>/dev/null && echo "✅ Formatted: $FILE"
    ;;
  *.go)
    gofmt -w "$FILE" 2>/dev/null && echo "✅ Formatted: $FILE"
    ;;
  *.json)
    if ! jq empty "$FILE" 2>&1; then
      echo "❌ Invalid JSON in $FILE" >&2
      exit 2
    fi
    ;;
esac

exit 0
```

### 2.4 進階 Hooks 技巧

**Conditional Hooks（v2.1.83+）**：只在特定條件下觸發：

```json
{
  "PreToolUse": [
    {
      "matcher": "Bash",
      "if": "tool_input.command.startsWith('git push')",
      "hooks": [...]
    }
  ]
}
```

**Effort Level 感知（W19）**：Hook 可讀取當前 effort level，依此調整行為：

```bash
EFFORT=$(echo "$INPUT" | jq -r '.effort.level // "medium"')
if [[ "$EFFORT" == "low" ]]; then
  # low effort 模式跳過耗時驗證
  exit 0
fi
```

**非阻斷操作加 `async: true`**：Slack 通知、備份等不應卡住 Claude：

```json
{
  "type": "command",
  "command": "~/.claude/hooks/notify-slack.sh",
  "async": true
}
```

**SessionStart 環境初始化**：每次 session 開始時自動同步 context：

```bash
#!/usr/bin/env bash
# 拉取最新 CLAUDE.md、注入 git 狀態
git pull --quiet origin main 2>/dev/null
echo "Current branch: $(git branch --show-current)"
echo "Last commit: $(git log --oneline -1)"
```

---

## 第三章：Prompt Caching 與 Context 工程

### 3.1 Cache 是生產系統的核心指標

Thariq Shihipar（Claude Code 核心團隊）：

> 「Cache rules everything. We treat it like uptime. When it drops, we have an incident.」

Cache Hit Rate 應列為與服務可用率同等重要的監控指標。命中率下降時立即排查根因（通常是以下三個）：

1. System prompt 被動態修改
2. 工具定義在 session 中增刪
3. Mid-session 切換了模型

**成本對比（以 Sonnet 4.6 為例）：**

| 操作 | 費率 |
|------|------|
| 一般輸入 token | $3 / MTok |
| Cache 寫入（1h TTL） | $6 / MTok |
| Cache 命中 | $0.30 / MTok（節省 90%） |

### 3.2 分層快取結構

最有效的快取結構是靜態到動態分層：

```
層 1（最穩定，快取效益最高）
  └─ System Prompt + Tools 定義

層 2（中度穩定）
  └─ 專案檔案（CLAUDE.md、codebase 概述）

層 3（每 session 不同）
  └─ 當次任務 context

層 4（每次請求不同）
  └─ 對話訊息（Messages）
```

**正確實作：**

```python
response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=4096,
    system=[
        {
            "type": "text",
            "text": STATIC_SYSTEM_PROMPT,
            "cache_control": {"type": "ephemeral"}  # 在最穩定層設 breakpoint
        },
        {
            "type": "text",
            "text": PROJECT_CONTEXT,           # 中度穩定層（不設 breakpoint）
        }
    ],
    messages=conversation_history,
)
```

### 3.3 五個禁止操作

以下任一操作都會導致快取完全失效：

1. **動態修改 system prompt**（如注入時間戳）→ 改用 `<system-reminder>` 在 messages 中注入
2. **Mid-session 切換模型** → 需換模型時用 Subagent（獨立 context）
3. **對話中增刪工具定義** → 用 stub + `defer_loading: true` 保持定義穩定
4. **Compact 時改變 system prompt** → 必須用完全相同的 system prompt 重建 session
5. **不一致的工具清單** → 每次請求工具定義 hash 必須相同

**正確的動態資訊注入方式：**

```xml
<!-- 在 messages 中注入，不修改 system prompt -->
<system-reminder>
  Current time: 2026-05-16 14:30 UTC
  Recently modified: src/api/routes.ts, src/services/auth.ts
  Current git branch: feature/oauth-refresh
  Open issues: #234 (high), #267 (medium)
</system-reminder>
```

### 3.4 Context Engineering：真正的護城河

Carta Healthcare 案例揭示了核心洞見：

> 「Context Engineering（在執行時組裝正確資訊並正確排序）才是真正的工程瓶頸，而非 prompt 撰寫。」

Context Engineering 的三個核心問題：

1. **填什麼**：只放「恰好所需的資訊」，不放過多（注意力稀釋）、不放過少（模型猜測）
2. **怎麼排序**：靜態放前（快取）、動態放後（減少失效）；長資料放最前（+30% 效能）
3. **何時 compact**：行為信號（模型問「你想做什麼？」）> 數字閾值（70%）> 定時器（每 300-400k token）

**Compact 決策樹：**

```
同一任務 context 仍相關 → Continue（不 compact）
走錯路徑 → /rewind（移除失敗嘗試）
中段膨脹、任務未完 → /compact <hint>（保持 context 但壓縮中間過程）
真正新任務 → /clear（完全清除）
大量中間輸出 → Subagent（隔離 context）
```

---

## 第四章：Subagent 委派策略

### 4.1 委派決策：核心心智模型

Thariq Shihipar 提供最精確的判斷框架：

> 「Subagent 是 context 管理的一種形式。Mental test：我需要工具輸出本身，還是只需要結論？只需結論 → 委派 subagent。」

**五個委派觸發條件（任一成立即委派）：**

| 條件 | 說明 |
|------|------|
| 讀取 ≥ 10 個檔案 | 研究型任務，context rot 風險高 |
| 預期工具呼叫 > 20 次 | 大量 tool noise 污染主對話 |
| 可拆 ≥ 3 個獨立子任務 | 平行 fan-out，單一訊息同時啟動 |
| 任務類型 ∈ {研究、安全審查、架構決策} | 類型觸發，不計數量 |
| 側邊任務會淹沒主線 | 保持主對話聚焦 |

### 4.2 拓撲規則

**Fan-out 上限 4**：單一訊息最多同時啟動 4 個 sub-agent（防止 context 過載）。

**通訊限 parent ↔ child**：child 間不直接溝通，失敗返回 parent 決策。

**child 不 self-retry**：失敗 → 返回主 Agent，由主 Agent 判斷是否重試或改策略。

**模型分層（AgentOpt 實測數據）：**

| 角色 | 推薦模型 | 原因 |
|------|---------|------|
| Orchestrator / Planner | Sonnet | 委派能力夠；Opus 當 Planner 反而繞過子代理 |
| Researcher / Analyst | Haiku | 高頻低複雜度，成本 13-32× 差距 |
| Implementer | Sonnet | 主要執行層 |
| Reviewer / Architect | Opus | 低頻高複雜度決策 |

**反直覺數據**：AgentOpt 實測 31.71% vs 74.27%——強模型當 Planner 反而最差；懂得委派的弱規劃者 > 什麼都自己做的強規劃者。

### 4.3 工具作用域隔離

不同角色的 subagent 應有不同的工具集，體現最小權限原則：

```yaml
---
name: security-reviewer
description: |
  Reviews code for security vulnerabilities.
  Do NOT use for: general code review, formatting, performance.
tools: Read, Grep, Glob    # 只讀，不寫，不執行
model: opus
effort: xhigh
---
```

| 角色 | 可用工具 | 禁止工具 |
|------|---------|---------|
| researcher | Read, Grep, Glob | Write, Edit, Bash |
| implementer | Read, Write, Edit, Bash | 無 |
| reviewer | Read, Grep, Glob | Write, Edit, Bash |
| test-writer | Read, Grep, Glob, Write | Bash（執行） |

### 4.4 平行化工作流

Boris Cherny 的高產出工作流：

```
開 3-5 個 git worktree → 各自 Claude session → 並行執行獨立工作
→ /test-and-fix 各自驗證
→ /review-changes 交叉審查
→ /grill（adversarial review，找漏洞）
→ /commit-push-pr
```

**Git Worktree 快速啟動：**

```bash
# 在新 worktree 啟動獨立 Claude session
claude -w feature/auth-refresh
claude -w feature/caching-layer
claude -w feature/api-rate-limiting
```

### 4.5 Advisor 模式

Advisor 工具讓 Executor 在複雜決策點向更強的 Advisor 模型諮詢：

**諮詢時機：**

- 架構決策前（尚未實作前）
- 核心邏輯實作前
- 宣告「完成」前

**諮詢格式（節省 35-45% tokens）：**

在 system prompt 加入：`The advisor should respond in under 100 words and use enumerated steps, not explanations.`

**成本效益：**

- Haiku（Executor）+ Opus（Advisor）：降低 85% 每任務成本，同等效能
- Sonnet（Executor）+ Opus（Advisor）：降低 11.9% 成本，提升 2.7% 效能

---

## 第五章：Skill 知識封裝

### 5.1 Skill 的本質

Skill 不是 markdown 文件，是組織機構知識的容器，可包含：

```
skills/processing-pdfs/
├── SKILL.md           # 主指令（必要，≤ 500 行）
├── config.json        # 用戶設定（可選）
├── scripts/           # 輔助腳本（可選）
│   └── validate.py
└── references/        # 深度文件（可選，只能一層）
    └── advanced-ocr.md
```

### 5.2 Description 的寫法：給模型看的，不是給人看的

```yaml
---
name: code-review
description: |
  Reviews code changes for quality, security, and style issues.
  Use whenever the user wants to review code, create a PR, or asks "is this good?".
  
  Do NOT use for: writing tests (use test-writer), debugging bugs (use debugger),
  refactoring code (use refactorer).
  
  Make sure to use this skill whenever the user mentions "review" or "PR".
allowed-tools: Read, Grep, Glob
---
```

**關鍵要素：**

1. **做什麼**（1-2 句，具體）
2. **何時用**（觸發條件，盡量具體）
3. **何時不用**（Do NOT use for，防止過度觸發）
4. **主動觸發提示**（`Make sure to use this skill whenever...`，模型傾向 undertrigger）

### 5.3 Progressive Disclosure：避免 Skill 膨脹

SKILL.md 超過 150 行就應該拆分：

```markdown
# SKILL.md（主體，≤ 150 行）

## 快速開始

Use `pdfplumber` for standard extraction:
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```

## 進階功能

For OCR, scanned PDFs, and form filling, see:
- references/ocr-guide.md（掃描版 PDF 處理）
- references/form-filling.md（表單填寫）

## Known Gotchas
- 加密 PDF 需傳入 password 參數
- 表格提取可能丟失格式，需後處理驗證
```

### 5.4 自由度分層原則

**反直覺**：風險越高的操作，自由度應越低。

| 操作類型 | 自由度 | 理由 |
|---------|--------|------|
| 程式碼 review、分析 | 高（文字指引） | 邊界失敗損害小 |
| Deploy、CI 腳本 | 中（Pseudocode + 參數化） | 需要彈性但有邊界 |
| DB 遷移、破壞性操作 | 低（精確腳本，禁止修改） | 失敗代價極高 |

### 5.5 Skill 生命週期管理

**評估套件（Enterprise 必備）：**

```markdown
## 評估案例集

### 應觸發
- "幫我 review 這個 PR"（✅ 觸發）
- "這段代碼有沒有問題？"（✅ 觸發）

### 不應觸發
- "幫我寫 unit tests"（❌ 不觸發，用 test-writer）
- "這個 bug 怎麼修？"（❌ 不觸發，用 debugger）

### 邊界案例
- "幫我看看這段有沒有安全問題"（⚠️ 需判斷是 review 還是 security-audit）
```

**保留門檻（30 天評估）：**

- 品質提升 ≥ 1.5 分（10 分制）+ 時間節省 ≥ 30%，兩者同時達標才保留
- 0 觸發次數 → 停用

**API 最大 Skill 數量：8 個**。超過後 Claude 的 recall accuracy 顯著下降，建議按角色分組，不要同時載入所有 Skill。

---

## 第六章：MCP 整合與工具擴展

### 6.1 MCP 的定位

MCP（Model Context Protocol）是 Claude 連接外部世界的標準協議，3 億月下載量（2026-04）印證市場採用已過臨界點。

**職責分離原則：**

```
MCP Server    → 連接（工具、外部 API、資料庫）
Skills        → 邏輯（領域知識、工作流、最佳實踐）
Subagents     → 任務委派（隔離 context、並行執行）
Hooks         → 自動化（確定性流程，非 Claude 控制）
```

### 6.2 三種 Transport 模式

```bash
# HTTP transport（推薦，適合遠端服務）
claude mcp add --transport http stripe https://mcp.stripe.com

# Stdio transport（本地工具，如 DB）
claude mcp add --transport stdio db -- npx -y @bytebase/dbhub \
  --dsn "postgresql://readonly:pass@prod.db.com:5432/analytics"

# 帶 OAuth 認證
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ \
  --header "Authorization: Bearer $GITHUB_PAT"
```

### 6.3 Scope 優先序

```
Local（當前 project）> Project（團隊共享）> User（跨 project）
```

同名 server 只連一次（Local 覆蓋 Project 覆蓋 User）。

### 6.4 Tool Search：按需載入工具 Schema

預設 MCP 工具 lazy-load（需 Sonnet 4+ 支援），可大幅減少 context 消耗：

```json
{
  "name": "heavy_analysis_tool",
  "description": "Advanced analysis capabilities",
  "defer_loading": true    // 按需載入，不一次展開所有 schema
}
```

Anthropic 實測：-85% tool schema token（2026-05）。

**`alwaysLoad: true`** 強制 upfront 載入（適用於高頻工具）：

```json
{
  "mcpServers": {
    "core-tools": {
      "alwaysLoad": true
    }
  }
}
```

### 6.5 MCP 輸出控制

```json
// .mcp.json
{
  "mcpServers": {
    "database-tools": {
      "type": "stdio",
      "command": "/path/to/server",
      "env": {
        "MAX_MCP_OUTPUT_TOKENS": "50000"  // 預設 25,000
      }
    }
  }
}
```

單工具最大輸出：500,000 字元（透過 `_meta["anthropic/maxResultSizeChars"]` 設定）。

---

## 第七章：安全部署與權限控制

### 7.1 多層防禦架構

安全不是單一機制，而是多層縱深：

```
Permission 層（Claude 工具呼叫控制）
    ↓
Sandbox 層（OS 層 Filesystem/Network 隔離）
    ↓
Proxy 層（網路流量控制 + 憑證管理）
    ↓
Container 層（Docker/gVisor/VM 隔離）
```

### 7.2 Permission 系統

**評估規則：deny → ask → allow，第一匹配勝出**

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(git commit *)",
      "Bash(git log *)",
      "Bash(* --version)"
    ],
    "deny": [
      "Bash(git push --force *)",
      "Bash(rm -rf *)",
      "Read(~/.aws/credentials)",
      "Read(~/.ssh/*)",
      "Read(.env*)"
    ]
  }
}
```

**Wildcard 語法注意事項：**

- `Bash(npm run *)` 匹配 `npm run test` 但**不**匹配 `npm run-linter`（無 word boundary）
- `Bash(curl *)` 容易被 redirect/protocol 繞過 → 改用 `deny Bash(curl *)` + `WebFetch(domain:...)` 組合
- Process wrapper 自動剝離：`timeout`、`time`、`nice` 等自動移除；`docker exec`、`npx` **不剝離**

### 7.3 Sandboxing

**OS 層隔離（建議啟用）：**

```json
{
  "sandbox": {
    "enabled": true,
    "filesystem": {
      "allowWrite": ["/workspace", "/tmp"],
      "denyRead": ["~/.aws", "~/.ssh", "~/.config/gcloud"]
    },
    "network": {
      "allowedDomains": [
        "github.com",
        "npm.org",
        "api.anthropic.com"
      ]
    }
  }
}
```

**技術比較：**

| 技術 | 隔離強度 | 效能負擔 |
|------|---------|---------|
| macOS Seatbelt | 好 | 極低 |
| Linux bubblewrap | 好 | 極低 |
| Docker（標準設定） | 中 | 低 |
| gVisor | 極佳 | 中（File I/O 10-200×） |
| Firecracker VM | 極佳 | 高（但啟動 < 125ms） |

### 7.4 憑證管理的 Proxy Pattern

**核心原則：Agent 永遠看不到實際 API Key。**

```bash
# Proxy 設定（Agent 只看到 proxy，不看到真實 key）
export ANTHROPIC_BASE_URL="http://localhost:8080"

# Proxy 負責：
# 1. 注入真實 API Key
# 2. 強制 allowlist（只允許白名單域名）
# 3. 稽核記錄（所有請求留存）
# 4. 速率限制
```

**Docker 生產設定（最小權限）：**

```bash
docker run \
  --cap-drop ALL \
  --security-opt no-new-privileges \
  --read-only \
  --tmpfs /tmp:rw,noexec,nosuid,size=100m \
  --network none \
  --memory 2g \
  --cpus 2 \
  --pids-limit 100 \
  --user 1000:1000 \
  -v /path/to/code:/workspace:ro \
  agent-image
```

**敏感檔案排除清單（掛載前必須排除）：**

`.env`、`~/.git-credentials`、`~/.aws/credentials`、`~/.kube/config`、`.npmrc`、`*.pem`、`*.key`、`~/.ssh/*`

---

## 第八章：Routines 排程自動化

### 8.1 Routine 是什麼

Routine = 儲存的 Claude Code 設定（prompt + repository + connectors），在 Anthropic 管理的雲端基礎設施上自動執行，筆電關掉仍繼續運作。

**三種觸發模式：**

| 觸發 | 用途 | 範例 |
|------|------|------|
| **Schedule** | 定期任務 | 每週日自動整理 backlog |
| **API** | 外部系統觸發 | CI/CD 部署後驗證 |
| **GitHub Event** | Repo 事件觸發 | PR 開啟時自動 review |

### 8.2 自動化配方（Boris Cherny 實戰）

Boris 用 `/loop` 實現全自動工作流：

```bash
# PR 自動 shepherd（每 5 分鐘）
/loop 5m /babysit
# → 監控 PR 狀態 → 回應 reviewer 留言 → 推更新

# Slack 回饋轉 PR（每 30 分鐘）
/loop 30m /slack-feedback
# → 讀取 #feedback 頻道 → 分析問題 → 建立對應 PR

# Post-merge 掃尾（每次 merge 後）
/loop /post-merge-sweeper
# → 處理 merge 後遺留的 review 留言

# Stale PR 清理（每 1 小時）
/loop 1h /pr-pruner
# → 關閉超過 30 天無活動的 PR
```

### 8.3 常見自動化場景

```markdown
## Backlog 維護 Routine
每週日 02:00 UTC 執行：
1. 讀取所有 open issues
2. 依標籤分類（bug/feature/docs）
3. 根據最近 commit 判斷優先級
4. 發 Slack 摘要到 #engineering 頻道

成功定義：所有 issues 有標籤 + Slack 訊息發出
```

**Routine Prompt 撰寫要求：**

Routine 以自主模式執行，prompt 必須完整自給：

- 明確說明目標（做什麼）
- 明確說明成功定義（怎樣算完成）
- 包含異常處理說明（找不到資源時怎麼辦）
- 不依賴互動式確認

### 8.4 使用限額

| 方案 | 每日執行次數 |
|------|------------|
| Pro | 5 次 |
| Max | 15 次 |
| Team | 25 次 |
| Enterprise | 依合約 |

---

## 第九章：成本工程與效能優化

### 9.1 三層成本防線

**層一：API 層（模型智能分層）**

使用 Advisor Tool 讓低成本模型處理高頻任務：

```
Haiku（Executor，高頻低複雜）
  + Opus（Advisor，低頻高複雜決策）
= 降低 85% 每任務成本，同等效能
```

**層二：Context 層（靜態前置快取）**

System Prompt + Tools 完全靜態 → Prompt Caching → Cache Hit Rate 90% → 節省 90% 輸入費用

**層三：工具層（按需展開工具 Schema）**

Tool Search（`defer_loading: true`）→ 降低 85% tool schema token → 更多可用 context 給真正的任務

### 9.2 Effort Level 選擇

| Level | 適用場景 | 特性 |
|-------|---------|------|
| `low` | 簡單格式轉換、查詢 | 跳過思考，最快 |
| `medium` | 一般 bug fix、功能實作 | 平衡品質與速度 |
| `high` | 多檔案重構、複雜邏輯 | 較多思考 |
| `xhigh` | Agentic 任務（推薦預設） | 自適應思考 |
| `max` | 架構設計、安全審查 | 最深度思考 |

**Opus 4.7 特性**：Adaptive Thinking（非固定 budget），模型自決思考深度。`xhigh` 是 agentic 編碼的推薦預設。

### 9.3 CJK 內容的特殊注意

**禁止使用 token-pruning 類壓縮工具（如 LLMLingua）處理繁體中文/日文/韓文內容。**

原因：對 CJK token 的重要性評估嚴重偏差，實測繁中內容衰退 25% 以上。

CJK 安全的替代方案：

1. 官方 Prompt Caching（零品質風險）
2. 輸出規則約束（caveman rules）：

```
[OUTPUT RULES — STRICT]
No preamble, no acknowledgement, no filler phrases.
Answer directly. Skip restating the question.
Bullets over prose. Code: minimal, no obvious comments.
Max 150 words unless code block dominates.
```

實測：英文 -80.6%、繁中 -86.2%，LLM Judge 品質無衰退。

### 9.4 量化成效案例

| 組織 | 改善指標 | 數據 |
|------|---------|------|
| Anthropic Engineering | 每日合併 PR 數 | +67% |
| Anthropic Marketing | 廣告創作時間 | 30 分鐘 → 30 秒 |
| Anthropic Legal | 合規審閱周轉 | 2-3 天 → 24 小時 |
| eSentire | 威脅分析時間 | 5 小時 → 7 分鐘（95% 準確率） |
| Skyline（70 萬行 C#）| 功能開發時間 | 一年專案 → 兩週 |

---

## 第十章：官方驗證心法與完成標準

### 10.1 PGE 原則（Generator ≠ Evaluator）

**核心原則**：產生程式碼的模型不應是評估程式碼的模型。

```bash
# 正確驗證流程（PGE 原則）
1. Claude 實作功能（Generator）
2. bash scripts/healthcheck.sh（External Evaluator）
3. 展示前 5 行 / 後 5 行輸出（禁止口頭聲稱「測試通過」）
4. 失敗時完整貼出錯誤，不省略
```

### 10.2 完成前自問清單

Boris Cherny 的完成驗證心法：

> 「宣告完成前自問：資深工程師會核准這個嗎？否 → 先修再報。」

**完成驗證的可觀測條件（開工前就寫）：**

```markdown
## 成功條件（開工前定義）
- [ ] `npm test` 全部通過（0 failures）
- [ ] TypeScript 無 type error（`npm run typecheck` 乾淨）
- [ ] API 端點回傳正確 HTTP status codes
- [ ] 效能：P95 < 200ms（用 `/usr/bin/time` 量測）
- [ ] No secrets in git history（`git-secrets` 掃描）
```

### 10.3 Checkpoint 規範

每完成一個重要步驟輸出 1 句摘要：

```
Checkpoint：做了什麼 / 驗了什麼 / 剩什麼
```

無法描述當前狀態時 → 停下重述，不繼續推進。

---

## 附錄 A：可直接套用的 Prompt 模板集

### A.1 專案 CLAUDE.md 範本

```markdown
# [專案名稱]

> 繁體中文優先 · 技術術語保留英文

## 常用指令
- 開發：`npm run dev`（啟動在 :3000）
- 測試：`npm test`（跑全部）；`npm run test:unit <file>`（跑單檔）
- 型別：`npm run typecheck`
- 格式：`npm run format`（提交前必跑）
- Healthcheck：`bash scripts/healthcheck.sh`

## 架構
- 路由：`src/routes/`
- 邏輯：`src/services/`（業務邏輯只放這裡）
- 資料庫：`src/repositories/`

## 非顯而易見規則
- `.env.test` 用於測試環境
- API 錯誤一律用 `{ error: string, code: string }` 格式
- 新功能必須附 E2E 測試

## 禁止事項
- 不直接在 routes 寫業務邏輯
- 不 commit `.env` 類敏感檔案
- 不用 `git push --force` 到 main
```

### A.2 複雜任務 System Prompt 範本

```xml
<system_context>
  <role>你是一位資深全端工程師，專注於 TypeScript + PostgreSQL 專案。</role>
  <codebase>
    - 架構：Express API + React 前端
    - 測試：Jest (unit) + Playwright (e2e)
    - 部署：GCP Cloud Run
  </codebase>
</system_context>

<working_principles>
  <think_before_coding>
    實作前先說明：
    1. 對需求的詮釋（≤2 句，非複述原話）
    2. 關鍵假設
    3. 若有多種解法列選項讓用戶確認
  </think_before_coding>
  
  <use_parallel_tool_calls>
    若多個工具呼叫互相獨立，同時發出，不要逐一執行。
  </use_parallel_tool_calls>
  
  <verify_before_claiming_done>
    宣告完成前必須執行驗證指令並展示輸出。
    禁止口頭聲稱「測試通過」。
  </verify_before_claiming_done>
</working_principles>

<output_discipline>
  - 無開場白（不說「當然」「以下是」）
  - 不重述問題
  - 純文字回答 ≤ 150 字
  - 程式碼只加非顯而易見的 comment
</output_discipline>
```

> **Prompt Caching 搭配說明**：此 System Prompt 作為靜態前綴時，在 API 請求中對最外層 system 陣列元素加上 `"cache_control": {"type": "ephemeral"}` breakpoint，確保快取命中。外部使用者輸入若作為 Agent 目標，應用 `<untrusted_objective>` 包裹防止 Prompt Injection。

### A.3 Subagent 委派範本

```
請同時啟動以下三個 subagent 並行執行（各自獨立，互不依賴）：

Agent 1 — researcher（工具：Read, Grep, Glob）：
  任務：分析 src/auth/ 目錄的認證流程，找出所有 JWT 相關的驗證邏輯
  完成條件：輸出流程圖（mermaid）+ 潛在安全問題清單

Agent 2 — test-writer（工具：Read, Grep, Glob, Write）：
  任務：為 src/auth/middleware.ts 補充缺少的測試案例
  完成條件：新增測試覆蓋 happy path + 3 個邊界案例 + 2 個錯誤案例

Agent 3 — doc-writer（工具：Read, Grep, Glob, Edit）：
  任務：更新 docs/auth.md，與目前實作保持一致
  完成條件：所有 API 端點有文件 + 範例 cURL 指令

三個 agent 完成後向我匯報摘要（非原始輸出）。
```

### A.4 Routine Prompt 範本

```markdown
# Weekly Backlog Triage Routine

## 目標
每週日 02:00 UTC 自動整理 GitHub issues backlog。

## 步驟
1. 讀取所有 open issues（label 未設定的優先）
2. 依以下規則分類：
   - `bug`：標題含「error」「fail」「broken」「crash」
   - `enhancement`：標題含「add」「improve」「support」「feature」
   - `docs`：標題含「doc」「readme」「guide」「example」
3. 依最近 7 天 commit 相關度評估優先級（high/medium/low）
4. 在 issues 加上對應 label 和 priority label
5. 發送 Slack 摘要到 `#engineering-weekly` 頻道

## 成功定義
- 所有未標記 issues 都有至少一個 type label
- Slack 訊息包含：本週新 issues 數量、分類統計、Top 3 high priority

## 異常處理
- GitHub API 失敗：等 5 分鐘後重試一次；仍失敗則發 Slack 告警
- Slack 發送失敗：記錄到 issue comment，不中止執行
```

### A.5 Prompt Caching 最佳實踐範本

```python
import anthropic

client = anthropic.Anthropic()

STATIC_SYSTEM = """
You are a senior software engineer specializing in TypeScript and PostgreSQL.
[... 詳細的靜態規則，例如 1000+ tokens ...]
"""

PROJECT_CONTEXT = """
# Project Architecture
[... 專案結構說明 ...]
"""

def make_request(user_message: str, conversation_history: list) -> str:
    """
    最佳化的 Prompt Caching 請求。
    靜態系統提示設 breakpoint，動態資訊在 messages 中注入（不修改 system prompt）。
    
    關鍵原則：
    - system 陣列內容必須保持 100% 靜態，breakpoint 才能穩定命中
    - 動態資訊（時間、branch、最近修改）放在 user message 的 content 中
    - 用 <system-reminder> XML tag 標記動態段，讓 Claude 區分動態/靜態
    - 這樣 system 前綴不變 → 快取持續命中
    """
    from datetime import datetime
    # 動態資訊作為 user message 的前綴（<system-reminder> tag 告知 Claude 這是動態注入）
    # 注意：這不是修改 system prompt，是在 messages 層注入，兩者完全不同
    dynamic_context = f"""<system-reminder>
Current time: {datetime.utcnow().isoformat()}Z
Current working branch: main
</system-reminder>"""
    
    # system prompt 保持完全靜態 → 快取穩定命中
    # 動態資訊在 user message 中 → 不影響 system 前綴
    messages = conversation_history + [
        {"role": "user", "content": f"{dynamic_context}\n\n{user_message}"}
    ]
    
    response = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=4096,
        system=[
            {
                "type": "text",
                "text": STATIC_SYSTEM,
                "cache_control": {"type": "ephemeral"}  # 靜態層設 breakpoint
            },
            {
                "type": "text",
                "text": PROJECT_CONTEXT,
                # 不設 breakpoint（中間層讓系統自動處理）
            }
        ],
        messages=messages,
    )
    
    # 監控 cache hit rate
    usage = response.usage
    hit_rate = usage.cache_read_input_tokens / (
        usage.cache_read_input_tokens + 
        usage.cache_creation_input_tokens + 
        usage.input_tokens
    ) if (usage.cache_read_input_tokens + usage.cache_creation_input_tokens + usage.input_tokens) > 0 else 0
    
    print(f"Cache hit rate: {hit_rate:.1%}")
    
    return response.content[0].text
```

---

## 附錄 B：快速決策參考

### B.1 CLAUDE.md vs Auto Memory vs Skill

| 儲存在哪 | 什麼內容 | 何時用 |
|---------|---------|--------|
| CLAUDE.md | 規則、指令、架構約束 | 每次 session 都需要知道的事 |
| Auto Memory | 學習成果、debug insights | Claude 自動判斷，無需手動管 |
| Skill | 可重用領域知識、工作流 | 特定任務類型的專業指引 |

### B.2 何時委派 Subagent

```
讀取 ≥ 10 檔 → 委派 researcher
工具呼叫 > 20 次 → 委派給適合的 agent
可拆 ≥ 3 獨立任務 → 平行 fan-out（最多 4 個）
只需結論，不需中間過程 → 委派 subagent
```

### B.3 Context 狀態決策

```
context 0-40%  → 無限制，正常執行
context 40-70% → 聚焦，避免引入新話題
context 70-85% → 主動 /compact <hint>
context 85-95% → 停止新任務，完成手頭工作
context 95%+   → 立即 /clear，新 session 繼續
```

---

## 附錄 C：官方驗證工具

```bash
# Workspace 完整性
bash scripts/healthcheck.sh

# Token 使用量量測
bash .claude/skills/harness-meta/scripts/measure.sh

# Source 驗證（Ratchet gate）
bash .claude/skills/harness-meta/scripts/source-verify.sh "<artifact>"

# Session 回顧（Dream Pass）
python .claude/skills/harness-meta/scripts/dream.py
```

---

*報告生成時間：2026-05-16*  
*來源：research/best-practices/（29 篇）+ research/claude-blog/（52 篇）*  
*待三方確認：autoresearch + research-hub*
