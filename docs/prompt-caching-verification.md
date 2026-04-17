# Prompt Caching 驗證指南

> 確認 CLAUDE.md + `@` 引用規則是否命中 Anthropic 的 ephemeral cache，降低第 2 輪起的 startup 成本。

## 為何重要

- 本 workspace startup context 約 3.5 KB（@ 自動展開後），約 1,100 tokens。
- 若命中 cache：後續每輪 `cache_read_input_tokens` 回填，**實際成本 ≈ 0**。
- 未命中時每輪重新計費 1,100 tokens × 會話長度 × 模型費率。

## 驗證方法

### 1. Claude Code CLI

```bash
# 檢視最近請求的 cache 統計
claude --stats   # 若支援
# 或檢查 session 日誌
grep cache_read ~/.claude/logs/*.jsonl | tail -5
```

### 2. Anthropic API 直接呼叫

回應 JSON 中關注 `usage` 欄位：

```json
"usage": {
  "input_tokens": 150,
  "cache_creation_input_tokens": 0,
  "cache_read_input_tokens": 1100,   // ← 這個 > 0 代表命中
  "output_tokens": 80
}
```

- `cache_creation_input_tokens` > 0：首次寫入 cache（+25% 費率）
- `cache_read_input_tokens` > 0：命中（僅 10% 費率）
- 兩者皆 0：cache miss 或 breakpoint 錯位

## 確保命中的設計原則

1. **靜態優先**：CLAUDE.md + `@` 引用在 system prompt 最前段，整段保持穩定。
2. **Breakpoint 位置**：在「規則區塊結尾、使用者訊息前」設 `cache_control: {"type": "ephemeral"}`。
3. **5 分鐘 TTL**：閒置超過 5 分鐘會過期；連續互動可延續。
4. **規則微調即失效**：編輯 `rules/*.md` 任一字元，下一輪需重建 cache（+25% 費率一次）。
   - 實務：頻繁微調的內容放在使用者訊息層，不要動 rules。

## 失效排查

| 症狀 | 可能原因 | 解法 |
|---|---|---|
| `cache_read = 0` 持續 | Breakpoint 沒設或位置錯 | 確認 system prompt 區段有標 ephemeral |
| 每輪 `cache_creation > 0` | 靜態區有變動 | 檢查 CLAUDE.md / rules 是否被 hook 改寫 |
| 偶發 miss | TTL 過期 | 接受或改用 1hr cache（成本權衡） |

## 參考

- Anthropic 官方文件：<https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching>
- 本 repo `.claude/REFERENCES.md` 收錄的 caching 決策來源

## 本 workspace cache 友善度現況（2026-04-17）

| 檢查項 | 狀態 | 說明 |
|---|:---:|---|
| @import 鏈無時間戳 | ✓ | CLAUDE.md + 3 規則檔均為語意穩定內容 |
| Memory.md 不進 @import | ✓ | 已重置空白，跨輪異動不破壞 cache |
| 工具定義穩定 | ✓ | 未動態改寫 `.claude/settings.json` 的 tool 區段 |
| `<system-reminder>` 附加於訊息層 | ✓ | hooks 透過 prompt submit 注入，未改上層 prompt |
| 模型固定 | ✓ | `claude-opus-4-7` 鎖定；中途切換會整段失效 |
| 啟動 @import 總量 | 9.2 KB (~2,300 tokens) | 符合「cache 一次、多輪受益」設計 |

**未啟用項**：Claude Code 平台層的 `cache_control: ephemeral` 標記由 harness 自動管理，workspace 無直接控制權。**只要維持上述 6 項 ✓，平台會自動套用 5 分鐘 TTL cache**（本篇其餘章節的 API 層驗證步驟適用於直接呼叫 Anthropic API 的情境）。
