# Timeout 設定影響分析報告

**分析日期**: 2026-04-14  
**分支**: `claude/karpathy-optimization-merged`  
**分析對象**: `CLAUDE_ENABLE_STREAM_WATCHDOG`、`CLAUDE_STREAM_IDLE_TIMEOUT_MS`、`API_TIMEOUT_MS`、`BASH_DEFAULT_TIMEOUT_MS`、`BASH_MAX_TIMEOUT_MS`

---

## 一、設定清單（最終版）

```json
{
  "env": {
    "CLAUDE_ENABLE_STREAM_WATCHDOG": "1",
    "CLAUDE_STREAM_IDLE_TIMEOUT_MS": "120000",
    "API_TIMEOUT_MS": "900000",
    "BASH_DEFAULT_TIMEOUT_MS": "300000",
    "BASH_MAX_TIMEOUT_MS": "1800000"
  }
}
```

> **版本說明**：初版 `CLAUDE_STREAM_IDLE_TIMEOUT_MS` 為 `60000`，分析後調整為 `120000`，原因見第三節。

---

## 二、各組件影響矩陣

### Hooks 層

| Hook | 觸發時機 | 估計執行時間 | 受影響設定 | 風險 |
|------|---------|------------|-----------|------|
| `session-init.sh` | SessionStart | 1–30 秒（雲端首次 clone 較長）| 無（Hooks 不受 BASH_*_TIMEOUT_MS 控制）| 🟢 低 |
| `memory-pull.sh` | PreToolUse (Read) | 1–5 秒 | 無 | 🟢 低 |
| `memory-update-hook.sh` | PostToolUse (Write/Edit) | < 1 秒（主體），背景 sync 另跑 | 無 | 🟢 低 |
| `memory-sync.sh` | 由 memory-update-hook 以 `&` 背景執行 | 3–30 秒（含重試）| 無（背景程序，與串流脫鉤）| 🟢 低 |
| `pre-commit-review.sh` | PreToolUse (Bash) | < 1 秒 | 無 | 🟢 低 |
| `stop-hook-git-check.sh` | Stop | < 2 秒（全為本地 git 操作）| 無 | 🟢 低 |

**重要澄清**：`BASH_DEFAULT_TIMEOUT_MS` 與 `BASH_MAX_TIMEOUT_MS` 只控制 Claude Code **Bash tool** 的執行時間，**不影響** hooks 腳本的執行。Hooks 是由 Claude Code 程序直接 spawn 的 shell process，走不同的執行路徑。

### Agents 層

| Agent | 模型 | 使用 Bash tool？ | BASH_*_TIMEOUT 影響 | Watchdog 風險 |
|-------|-----|----------------|---------------------|--------------|
| `researcher` | Haiku | 否（Glob/Grep/Read/WebFetch）| 無 | 🟢 無 |
| `architecture-explorer` | Haiku | 是（Bash）| 預設 5 分鐘，足夠 | 🟢 低 |
| `implementer` | Sonnet | 是（核心使用）| **重要**：見下方說明 | 🟡 中 |
| `test-writer` | Sonnet | 是（執行測試）| **重要**：見下方說明 | 🟡 中 |
| `reviewer` | Opus | 否（Read/Grep/Glob）| 無 | 🟢 無 |
| `security-reviewer` | Sonnet | 否（Read/Grep/Glob）| 無 | 🟢 無 |

#### `implementer` & `test-writer` 的中等風險說明

這兩個 agent 會執行如 `npm test`、`pytest`、`cargo build` 等可能長時間靜默的指令。

**風險情境**：
```
npm test（無 verbose 輸出）
  → 靜默執行 100 秒
  → CLAUDE_STREAM_IDLE_TIMEOUT_MS=120000（2 分鐘）
  → 100 秒 < 120 秒，安全
  
cargo build（大型 Rust 專案）
  → 靜默執行 3 分鐘
  → 3 分鐘 > 120 秒
  → Watchdog 偵測到 idle，觸發重連機制
```

**緩解方式**：對可能靜默的長時間指令，加入 verbose flag（如 `npm test --verbose`、`cargo build 2>&1`），確保有持續輸出。

### Skills 層

| Skill | 是否涉及長時間操作 | 影響 |
|-------|----------------|------|
| `deep-review` | 否（靜態分析）| 🟢 無影響 |
| `cost-tracker` | 否（讀取 log 計算）| 🟢 無影響 |
| `frontend-design` | 否（設計指引）| 🟢 無影響 |
| `agent-team` | 是（平行多 worker）| 🟡 若 worker 執行長時間靜默 Bash，有風險 |
| `session-start-hook` | 否（設定相關）| 🟢 無影響 |

---

## 三、關鍵調整：`CLAUDE_STREAM_IDLE_TIMEOUT_MS` 從 60s → 120s

### 初版問題

`60000`（60 秒）選值的出發點是「比企業代理 idle timeout 更早偵測」，但忽略了對 `implementer`/`test-writer` agent 的影響：很多 build/test 工具在 60 秒內靜默執行屬正常行為。

### 調整依據

| 考量 | 60s | 120s |
|------|-----|------|
| 企業代理（最嚴格 60s）| 可偵測到 | 可能來不及（已超時）|
| 企業代理（一般 90-120s）| 仍有效 | 有效 |
| npm test / pytest（< 2 分鐘）| 🔴 可能中斷 | 🟢 安全 |
| cargo build / webpack（> 2 分鐘）| 🔴 必然中斷 | 🟡 仍有風險，需 verbose |
| 使用者體驗（偵測速度）| 更快重連 | 稍慢，但更穩定 |

**結論**：`120000`（2 分鐘）在「代理相容性」與「長時間任務穩定性」之間取得更好的平衡。

### 特殊情境指引

如果你確定在**嚴格 60 秒 idle timeout 的企業代理**環境下使用，可手動調回 `60000`，但需注意 `implementer` 執行測試時盡量加 verbose flag。

---

## 四、設定優先級衝突分析

### 兩份 settings.json 的關係

```
/root/.claude/settings.json           (全域，適用所有 Claude Code 工作階段)
  └── env: 5 個 timeout 設定
  └── hooks: Stop hook
  └── permissions: allow Skill

.claude/settings.json                 (專案層級，覆蓋全域同名鍵)
  └── env: 5 個 timeout 設定（與全域相同）
  └── hooks: SessionStart、PreToolUse、PostToolUse
```

**合併結果**：
- `env` 區塊：專案覆蓋全域，值相同，無實際衝突
- `hooks` 區塊：**合併**（Claude Code 對 hooks 採合併策略而非覆蓋）
- `permissions`：來自全域，專案未定義，保持有效

**有效 hooks 組合（合併後）**：
```
SessionStart  → session-init.sh
PreToolUse(read) → memory-pull.sh
PreToolUse(bash) → pre-commit-review.sh
PostToolUse(write|edit) → memory-update-hook.sh
Stop → stop-hook-git-check.sh
```

所有 hooks 正確運作，無衝突。

---

## 五、`BASH_MAX_TIMEOUT_MS` vs `CLAUDE_STREAM_IDLE_TIMEOUT_MS` 的隱性張力

這是最重要的**架構層級矛盾**：

```
BASH_MAX_TIMEOUT_MS    = 30 分鐘  (允許 Bash tool 最長執行 30 分鐘)
CLAUDE_STREAM_IDLE_TIMEOUT_MS = 2 分鐘  (串流 2 分鐘無活動 → watchdog 介入)
```

**實際含義**：Bash tool 雖然理論上可以跑 30 分鐘，但若中間任何連續 2 分鐘沒有 stdout 輸出傳回串流，watchdog 就會介入，試圖重連或中斷。

**建議**：`BASH_MAX_TIMEOUT_MS` 的主要用途是「允許使用者要求更長的超時」（透過 `timeout_ms` 參數），實際上 Bash tool 超過 2 分鐘靜默就不實際。可考慮將 `BASH_MAX_TIMEOUT_MS` 從 30 分鐘降至 `600000`（10 分鐘）以反映實際限制，但這屬於優化建議，非必要修改。

---

## 六、風險摘要

| 維度 | 風險等級 | 說明 |
|------|---------|------|
| **Hooks 層整體** | 🟢 低 | 所有 hooks 執行時間遠低於任何 timeout 閾值 |
| **設定優先級衝突** | 🟢 無 | 兩份設定檔值一致，合併規則明確 |
| **Agents（researcher/reviewer/security-reviewer）** | 🟢 無 | 不使用 Bash tool |
| **Agents（implementer/test-writer）** | 🟡 中（可管理）| 長時間靜默 build/test 可能觸發 watchdog |
| **Skills（agent-team 的平行 worker）** | 🟡 中（可管理）| 同上，worker 需注意靜默輸出 |
| **BASH_MAX vs STREAM_IDLE 隱性矛盾** | 🟡 中（已知）| 30 分鐘上限與 2 分鐘靜默上限的功能落差 |
| **整體綜合評估** | 🟢 低至中（偏低）| 無破壞性變更，現有功能不受影響 |

---

## 七、使用建議

### 開發任務（日常）
現有設定已足夠，無需特別調整。

### 執行長時間 Build/Test（`implementer`/`test-writer`）
為靜默型指令加上 verbose flag：
```bash
# ✅ 推薦
npm test --verbose
pytest -v
cargo build 2>&1

# ⚠️ 可能觸發 watchdog（若超過 120 秒）
npm test
cargo build
webpack --config prod.config.js
```

### 嚴格企業代理環境（proxy idle < 60s）
臨時調整：
```json
"CLAUDE_STREAM_IDLE_TIMEOUT_MS": "45000"
```
但需同步確保所有 Bash 操作有持續輸出。
