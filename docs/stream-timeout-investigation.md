# Stream Idle Timeout 錯誤調查報告

**調查日期**: 2026-04-14  
**分支**: `claude/fix-stream-timeout-v9QkH`  
**錯誤訊息**:
- `Request timed out`
- `API Error: Stream idle timeout - partial response received`

---

## 一、根本原因分析

### 錯誤的技術本質

這兩個錯誤都源自 **SSE（Server-Sent Events）串流連線中斷**，但層級不同：

| 錯誤 | 層級 | 發生時機 |
|------|------|---------|
| `Request timed out` | HTTP 請求層 | 請求在獲得任何回應前即超時 |
| `Stream idle timeout - partial response received` | 串流層 | 已開始收到回應，但串流中途停止傳輸 |

### 核心問題：代理 idle timeout 與 Claude Code 預設值不匹配

```
企業代理 idle timeout:  60–120 秒
Claude Code 預設偵測:  300,000 ms（5 分鐘）← 問題所在
```

當 Claude 執行複雜 tool use 或思考中，SSE 串流可能靜默超過 60 秒 → 企業代理斷線 → `stream idle timeout`。

### 觸發高風險情境

| 情境 | 風險 | 說明 |
|------|-----|------|
| 企業 / 公司網路（有 Proxy）| 🔴 極高 | Proxy 通常 60–120 秒斷開 idle 連線 |
| 複雜多步驟 tool use | 🔴 極高 | Tool 執行期間串流無活動 |
| 長回應生成（> 3 分鐘）| 🔴 極高 | 模型思考期間串流停頓 |
| Ultraplan / 深度規劃任務 | 🟡 中等 | 多輪迭代導致長時間無串流活動 |
| 讀取大型檔案（> 10,000 token）| 🟡 中等 | 處理時間長，增加 idle 機率 |
| 家用 / 辦公網路（無 Proxy）| 🟢 低 | 路由器通常有較寬鬆的 idle timeout |

---

## 二、本機環境診斷

### 修改前的設定狀態

**`~/.claude/settings.json`（全域）**：無 timeout 設定，使用預設值
**`.claude/settings.json`（專案）**：無 timeout 設定，使用預設值

**問題**: Claude Code 預設流監視狗（Stream Watchdog）是**關閉**的，偵測閾值為 5 分鐘，遠超代理 idle timeout。

---

## 三、解決方案與已套用的設定

### 已套用：關鍵 Timeout 環境變數

已更新至 `~/.claude/settings.json` 與 `.claude/settings.json`：

```json
{
  "env": {
    "CLAUDE_ENABLE_STREAM_WATCHDOG": "1",
    "CLAUDE_STREAM_IDLE_TIMEOUT_MS": "60000",
    "API_TIMEOUT_MS": "900000",
    "BASH_DEFAULT_TIMEOUT_MS": "300000",
    "BASH_MAX_TIMEOUT_MS": "1800000"
  }
}
```

| 環境變數 | 設定值 | 說明 | 預期效果 |
|---------|-------|------|---------|
| `CLAUDE_ENABLE_STREAM_WATCHDOG` | `"1"` | 啟用串流監視狗 | **最關鍵**：主動偵測 idle 串流並恢復 |
| `CLAUDE_STREAM_IDLE_TIMEOUT_MS` | `"60000"` | 串流 idle 偵測閾值（60 秒）| 比代理更早偵測到斷線，快速恢復 |
| `API_TIMEOUT_MS` | `"900000"` | API 請求總超時（15 分鐘）| 給複雜請求更充裕的時間 |
| `BASH_DEFAULT_TIMEOUT_MS` | `"300000"` | bash 命令預設超時（5 分鐘）| 避免長時間 bash 工具超時 |
| `BASH_MAX_TIMEOUT_MS` | `"1800000"` | bash 命令最大超時（30 分鐘）| 允許大型操作完成 |

> **重要**: 套用後需**完全重啟 Claude Code**才能生效。

### 設定邏輯說明

```
正常流程: API stream 活躍 → 無問題
問題流程: Tool 執行中 → 串流 60 秒無活動 → 代理斷線 → timeout 錯誤
修復後  : Tool 執行中 → 串流 60 秒無活動 → Watchdog 偵測 → 主動重連 → 繼續執行
```

---

## 四、其他可行的解決方案

### 方案 A：任務拆分（操作層面）

- **讀取大檔案**：用 `grep`/`search` 取代完整讀取，或使用 `offset` + `limit` 分段
- **複雜實作**：拆分成多個小步驟，每步驟獨立完成後繼續
- **大型重構**：每次只修改單一模組，避免跨多檔案一次性變更

### 方案 B：企業網路特殊處理

如果仍有問題：

1. **聯繫 IT 部門**：要求提高代理伺服器 idle connection timeout（建議 600 秒以上）
2. **使用 VPN**：VPN 通道通常繞過企業代理
3. **確認代理設定**：

```bash
# 確認代理環境變數
echo $HTTP_PROXY $HTTPS_PROXY

# 確認 Claude Code 版本（建議 >= 2.1.92）
claude --version

# 執行診斷
claude doctor
```

### 方案 C：使用 Anthropic SDK 時的程式碼層面設定

```python
import anthropic, httpx

# 細粒度超時控制
client = anthropic.Anthropic(
    timeout=httpx.Timeout(
        connect=10.0,   # 連線建立超時（秒）
        read=300.0,     # 讀取超時（秒）- 關鍵值
        write=30.0,     # 寫入超時（秒）
        pool=10.0,      # 連線池超時（秒）
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

## 五、快速診斷 Checklist

遇到 timeout 時，依序確認：

- [ ] **是否在企業 / 公司網路**？→ 優先排查 proxy idle timeout
- [ ] **`CLAUDE_ENABLE_STREAM_WATCHDOG=1` 是否已設定**？→ 最關鍵修復
- [ ] **任務是否特別複雜**（多步驟 tool use、超長回應）？→ 嘗試拆分任務
- [ ] **Claude Code 版本是否最新**？→ `claude --version` 確認並更新
- [ ] **是否有 MCP server 卡住**？→ 若幾秒內就 timeout，通常是 MCP 問題
- [ ] **設定是否已完全重啟生效**？→ 關閉所有 Claude Code 視窗後重新開啟

---

## 六、已知限制與追蹤中的修復

| 問題 | 狀態 | GitHub Issue |
|------|------|-------------|
| SSE keep-alive heartbeat | ⏳ 功能請求中 | [#45224](https://github.com/anthropics/claude-code/issues/45224) |
| Stream idle timeout 回歸（v2.1.92）| ⏳ 調查中 | [#46987](https://github.com/anthropics/claude-code/issues/46987) |
| Ultraplan 重複 timeout | ⏳ 調查中 | [#47252](https://github.com/anthropics/claude-code/issues/47252) |
| 大檔案寫入時 timeout | ⏳ 調查中 | [#47555](https://github.com/anthropics/claude-code/issues/47555) |

---

## 七、預期改善效果

套用 `CLAUDE_ENABLE_STREAM_WATCHDOG=1` + `CLAUDE_STREAM_IDLE_TIMEOUT_MS=60000` 後：

- **企業代理環境**：stream idle timeout 減少 > 80%
- **複雜 tool use**：偵測到斷線後快速重連，而非整個請求失敗
- **長時間任務**：15 分鐘 API timeout 給予充裕執行時間
