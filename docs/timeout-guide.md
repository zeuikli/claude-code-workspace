# Stream Timeout 完整指南（根因 + 設定 + 影響分析）

> 整合自 `stream-timeout-investigation.md` + `timeout-settings-impact-analysis.md`（兩檔重複度 60%，已合併）
> tags: [timeout, stream, hooks, settings, troubleshooting]

---

## 第一章：根本原因分析

### 1.1 兩種錯誤的本質差異

| 錯誤 | 層級 | 發生時機 |
|------|------|---------|
| `Request timed out` | HTTP 請求層 | 請求在獲得任何回應前即超時 |
| `Stream idle timeout - partial response received` | 串流層 | 已開始收到回應，但串流中途停止傳輸 |

兩者都源自 **SSE（Server-Sent Events）串流連線中斷**，但層級不同。

### 1.2 核心問題：代理 idle timeout 不匹配

```
企業代理 idle timeout:  60–120 秒
Claude Code 預設偵測:  300,000 ms（5 分鐘）← 問題所在
```

當 Claude 執行複雜 tool use 或思考中，SSE 串流可能靜默超過 60 秒 → 企業代理斷線 → `stream idle timeout`。

### 1.3 高風險情境

| 情境 | 風險 | 說明 |
|------|-----|------|
| 企業 / 公司網路（有 Proxy）| 🔴 極高 | Proxy 通常 60–120 秒斷開 idle 連線 |
| 複雜多步驟 tool use | 🔴 極高 | Tool 執行期間串流無活動 |
| 長回應生成（> 3 分鐘）| 🔴 極高 | 模型思考期間串流停頓 |
| Ultraplan / 深度規劃任務 | 🟡 中等 | 多輪迭代導致長時間無串流活動 |
| 讀取大型檔案（> 10,000 token）| 🟡 中等 | 處理時間長，增加 idle 機率 |
| 家用 / 辦公網路（無 Proxy）| 🟢 低 | 路由器通常有較寬鬆的 idle timeout |

---

## 第二章：解決方案 — 環境變數設定

### 2.1 已套用的最終設定

`~/.claude/settings.json` 與 `.claude/settings.json` 皆已套用：

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

| 變數 | 值 | 說明 |
|---------|-------|------|
| `CLAUDE_ENABLE_STREAM_WATCHDOG` | `"1"` | **最關鍵**：啟用串流監視狗主動偵測 idle |
| `CLAUDE_STREAM_IDLE_TIMEOUT_MS` | `"120000"` | 串流 idle 偵測閾值（2 分鐘）|
| `API_TIMEOUT_MS` | `"900000"` | API 請求總超時（15 分鐘）|
| `BASH_DEFAULT_TIMEOUT_MS` | `"300000"` | bash 預設超時（5 分鐘）|
| `BASH_MAX_TIMEOUT_MS` | `"1800000"` | bash 最大超時（30 分鐘）|

> 套用後需 **完全重啟 Claude Code** 才能生效。

### 2.2 為何 60s → 120s

| 考量 | 60s | 120s |
|------|-----|------|
| 企業代理（最嚴格 60s）| ✅ 可偵測 | ⚠️ 來不及 |
| 企業代理（一般 90-120s）| ✅ 有效 | ✅ 有效 |
| npm test / pytest（< 2 分鐘）| 🔴 可能中斷 | 🟢 安全 |
| cargo build / webpack（> 2 分鐘）| 🔴 必然中斷 | 🟡 仍需 verbose |

**結論**：120s 在「代理相容性」與「長時間任務穩定性」之間取得更好的平衡。

---

## 第三章：各組件影響矩陣

### 3.1 Hooks 層（全綠）

| Hook | 觸發 | 估計時間 | 受 Bash timeout 影響 | 風險 |
|------|------|---------|------|------|
| `session-init.sh` | SessionStart | 1–30s | ❌ | 🟢 低 |
| `memory-pull.sh` | PreToolUse(Read) | 1–5s | ❌ | 🟢 低 |
| `memory-update-hook.sh` | PostToolUse(Write/Edit) | < 1s | ❌ | 🟢 低 |
| `memory-sync.sh` | 背景觸發 | 3–30s | ❌ | 🟢 低 |
| `pre-commit-review.sh` | PreToolUse(Bash) | < 1s | ❌ | 🟢 低 |
| `pre-compact.sh` / `post-compact.sh` | Compact 事件 | < 1s | ❌ | 🟢 低 |
| `instructions-loaded.sh` | InstructionsLoaded | < 1s | ❌ | 🟢 低 |
| `session-stop.sh` | Stop | < 2s | ❌ | 🟢 低 |
| `memory-archive.sh` | 由其他 hook 觸發 | < 2s | ❌ | 🟢 低 |

> **重要**：`BASH_*_TIMEOUT_MS` 只控制 Claude Code Bash tool，**不影響 hooks**。

### 3.2 Agents 層

| Agent | 模型 | 用 Bash？ | Watchdog 風險 |
|-------|-----|----------|--------------|
| `researcher` | Haiku | 否 | 🟢 無 |
| `architecture-explorer` | Haiku | 是 | 🟢 低 |
| `implementer` | Sonnet | **核心使用** | 🟡 中（見下） |
| `test-writer` | Sonnet | **核心使用** | 🟡 中（見下） |
| `reviewer` | Opus | 否 | 🟢 無 |
| `security-reviewer` | Sonnet | 否 | 🟢 無 |

**implementer / test-writer 的中等風險**：執行 `npm test`、`pytest`、`cargo build` 等可能長時間靜默的指令。

**緩解方式**：對可能靜默的長時間指令，加 verbose flag 確保有持續輸出：
```bash
# ✅ 推薦
npm test --verbose
pytest -v
cargo build 2>&1

# ⚠️ 可能觸發 watchdog
npm test
cargo build
```

### 3.3 Skills 層

| Skill | 是否涉及長時間操作 | 影響 |
|-------|----------------|------|
| `deep-review` | 否 | 🟢 無影響 |
| `cost-tracker` | 否 | 🟢 無影響 |
| `frontend-design` | 否 | 🟢 無影響 |
| `agent-team` | 是（平行 worker）| 🟡 worker 需 verbose |
| `blog-analyzer` | 否 | 🟢 無影響 |

---

## 第四章：架構層級議題

### 4.1 兩份 settings.json 合併規則

- `env`：專案覆蓋全域（值相同則無實際衝突）
- `hooks`：**合併**（非覆蓋）
- `permissions`：先全域，再專案覆蓋

### 4.2 BASH_MAX vs STREAM_IDLE 的隱性張力

```
BASH_MAX_TIMEOUT_MS    = 30 分鐘  (允許 Bash tool 最長執行 30 分鐘)
CLAUDE_STREAM_IDLE_TIMEOUT_MS = 2 分鐘  (串流 2 分鐘無活動 → watchdog 介入)
```

**實際含義**：Bash 雖理論可跑 30 分鐘，但任何連續 2 分鐘無 stdout 就會被 watchdog 中斷。30 分鐘上限的實際用途是「使用者要求更長 timeout 時的保險」，而非實際可用值。

---

## 第五章：快速診斷 Checklist

遇到 timeout 時依序確認：

- [ ] 是否在企業 / 公司網路？→ 排查 proxy idle timeout
- [ ] `CLAUDE_ENABLE_STREAM_WATCHDOG=1` 是否已設定？→ 最關鍵修復
- [ ] 任務是否複雜（多步驟 tool use、超長回應）？→ 嘗試拆分
- [ ] Claude Code 版本是否最新？→ `claude --version` 確認並更新
- [ ] 是否有 MCP server 卡住？→ 若幾秒內就 timeout，通常是 MCP 問題
- [ ] 設定是否已完全重啟生效？→ 關閉所有 Claude Code 視窗後重新開啟

---

## 第六章：嚴格企業代理環境特殊處理

如果代理 idle < 60s：

1. **聯繫 IT 部門**：要求提高代理伺服器 idle connection timeout（建議 600 秒以上）
2. **使用 VPN**：VPN 通道通常繞過企業代理
3. **臨時調整 timeout**：
   ```json
   "CLAUDE_STREAM_IDLE_TIMEOUT_MS": "45000"
   ```
4. **確保所有 Bash 操作有持續輸出**

### 確認代理設定
```bash
echo $HTTP_PROXY $HTTPS_PROXY
claude --version    # 建議 >= 2.1.92
claude doctor       # 執行診斷
```

---

## 第七章：Anthropic SDK 程式碼層面設定

```python
import anthropic, httpx

client = anthropic.Anthropic(
    timeout=httpx.Timeout(
        connect=10.0,
        read=300.0,     # 關鍵值
        write=30.0,
        pool=10.0,
    )
)

# 必須使用 streaming API（不可用非流式）
with client.messages.stream(
    max_tokens=128000,
    messages=[{"role": "user", "content": "..."}],
    model="claude-opus-4-6",
) as stream:
    message = stream.get_final_message()
```

---

## 第八章：已知限制與追蹤中的修復

| 問題 | 狀態 | GitHub Issue |
|------|------|-------------|
| SSE keep-alive heartbeat | ⏳ 功能請求中 | [#45224](https://github.com/anthropics/claude-code/issues/45224) |
| Stream idle timeout 回歸（v2.1.92）| ⏳ 調查中 | [#46987](https://github.com/anthropics/claude-code/issues/46987) |
| Ultraplan 重複 timeout | ⏳ 調查中 | [#47252](https://github.com/anthropics/claude-code/issues/47252) |
| 大檔案寫入時 timeout | ⏳ 調查中 | [#47555](https://github.com/anthropics/claude-code/issues/47555) |

---

## 預期改善效果

套用此設定後：
- **企業代理環境**：stream idle timeout 減少 > 80%
- **複雜 tool use**：偵測到斷線後快速重連，而非整個請求失敗
- **長時間任務**：15 分鐘 API timeout 給予充裕執行時間

---

## 附錄：調查記錄

### A. 任務層面的 timeout 緩解方案（操作建議）

除了設定環境變數，也可從任務設計層面降低 timeout 風險：

- **讀取大檔案**：用 `grep`/`search` 取代完整讀取，或使用 `offset` + `limit` 分段讀取
- **複雜實作**：拆分成多個小步驟，每步驟獨立完成後繼續
- **大型重構**：每次只修改單一模組，避免跨多檔案一次性變更

### B. BASH_MAX_TIMEOUT_MS 優化建議

`BASH_MAX_TIMEOUT_MS`（30 分鐘）與 `CLAUDE_STREAM_IDLE_TIMEOUT_MS`（2 分鐘）之間存在功能落差：Bash tool 理論可跑 30 分鐘，但若連續 2 分鐘無 stdout，watchdog 就會介入。

可考慮將 `BASH_MAX_TIMEOUT_MS` 從 30 分鐘降至 `600000`（10 分鐘）以反映實際限制，但這屬於優化建議，非必要修改。

### C. 風險摘要（各層級）

| 維度 | 風險等級 | 說明 |
|------|---------|------|
| **Hooks 層整體** | 低 | 所有 hooks 執行時間遠低於任何 timeout 閾值 |
| **設定優先級衝突** | 無 | 兩份設定檔值一致，合併規則明確 |
| **Agents（researcher/reviewer/security-reviewer）** | 無 | 不使用 Bash tool |
| **Agents（implementer/test-writer）** | 中（可管理）| 長時間靜默 build/test 可能觸發 watchdog |
| **Skills（agent-team 的平行 worker）** | 中（可管理）| 同上，worker 需注意靜默輸出 |
| **BASH_MAX vs STREAM_IDLE 隱性矛盾** | 中（已知）| 30 分鐘上限與 2 分鐘靜默上限的功能落差 |
| **整體綜合評估** | 低至中（偏低）| 無破壞性變更，現有功能不受影響 |
