# Hybrid Auto Memory 評估與採用指南

> 比較官方 Auto Memory 機制與本 workspace 自製 Memory.md + git push 鏈，並給出 **Hybrid 混用建議**。
> tags: [memory, auto-memory, hybrid, evaluation]

---

## 背景

Anthropic 2026 Q1 正式推出 **Auto Memory** 機制（存於 `~/.claude/projects/<project>/memory/`），由 Claude 自動累積學習。本 workspace 自 2026-04 起已有 `Memory.md` + 三段 hook（SessionStart / PreToolUse / PostToolUse）同步到 git。

二者各有優勢，**本文評估後決定採用 Hybrid 方案**。

---

## 機制對比

| 維度 | 官方 Auto Memory | 本 workspace Memory.md |
|---|---|---|
| **寫入者** | Claude 自動 | 人工 + Hook 半自動 |
| **儲存位置** | `~/.claude/projects/<id>/memory/` | `<repo>/Memory.md` |
| **檔案結構** | `MEMORY.md` (主) + topic files | 單檔 Session 串接 |
| **載入上限** | 首 200 行 / 25KB（自動截斷） | 完整載入（超過 200 行警告） |
| **Git 同步** | ❌ 機器本地 | ✅ 自動 push |
| **跨機器共用** | ❌ | ✅ |
| **跨 session 記憶** | ✅ | ✅ |
| **可人工編輯** | ⚠️ 需 `/memory` 指令 | ✅ 直接編輯 |
| **版本控制** | ❌ | ✅ |
| **壓縮策略** | 官方 AI 摘要 | 手動 archive |
| **適合內容** | 學習洞見、模式識別 | 結構化決策、指令、待辦 |

---

## Hybrid 採用原則

### 🟦 Memory.md 負責「**團隊共享指令層**」
- Session 完成事項
- 關鍵決策與技術選型
- 已修改檔案清單
- 下一步待辦
- 工作流程規範

### 🟨 Auto Memory 負責「**個人學習層**」
- 特定 codebase 的慣例（如「這個專案用 tRPC 不用 REST」）
- 常踩的坑（如「這個 API 的 rate limit 很嚴格」）
- 個人偏好（如「不要自動加 TypeScript 型別」）
- 觀察到的工作模式

### 🟩 交集處理
- 每月執行一次 `/memory` 審計
- 挑選 Auto Memory 中「有普遍價值」的內容，**手動 merge 回 Memory.md**
- 避免重複 — 同一資訊不同時存兩處

---

## 啟用 Auto Memory 步驟

### 1. 確認 Claude Code 版本
```bash
claude --version   # 建議 >= v2.1.0
```

### 2. 啟用 Auto Memory
在 Claude Code session 中執行：
```
/memory
```
→ 選擇「Enable Auto Memory」

### 3. 確認儲存位置
```bash
ls -la ~/.claude/projects/*/memory/
```

### 4. 日常使用
- Claude 會自動在 session 中學習並寫入
- 使用者無需手動操作
- 每月用 `/memory` 開啟 UI 審視內容

---

## 衝突解決策略

### 情境 A：Auto Memory 與 Memory.md 內容不一致
- **原則**：Memory.md（git 版控）為準
- 更新 Auto Memory：`/memory edit` 手動修改

### 情境 B：Auto Memory 發現有價值的內容
- 開啟 `/memory` UI
- 複製內容到 Memory.md 相應 Session
- 讓 Hook 自動 push 到 GitHub

### 情境 C：多機器同步需求
- Auto Memory **不** 會跨機器同步（機器本地）
- 需要同步的內容 → 一律放 Memory.md
- 不需同步的個人習慣 → 留在 Auto Memory

---

## 遷移檢查清單

若考慮將現有 Memory.md 內容遷移到 Auto Memory：

- [ ] **別做**：Memory.md 跨機器共用 + git 版控仍是核心價值
- [ ] **可做**：Memory.md 過舊的 Session（> 6 個月）轉為 Auto Memory topic file
- [ ] **該做**：啟用 Auto Memory 作為個人層，開始累積

---

## 監控指標

| 指標 | 目標 | 檢查方式 |
|---|---|---|
| Memory.md 大小 | < 200 行 / 25KB | `bash scripts/healthcheck.sh` |
| Auto Memory 使用率 | > 0 entries/week | `/memory` UI |
| 重複資訊 | 0 | 每月 `/memory` + Memory.md 對照審計 |

---

## 決策結論

> **建議：立即啟用 Auto Memory，但不取代 Memory.md。**

理由：
1. **互補而非互斥**：Auto Memory 擅長「Claude 自己發現的模式」，Memory.md 擅長「人工結構化紀錄」
2. **保險機制**：git 版控的 Memory.md 是最後防線，機器本地 Auto Memory 易失
3. **漸進採用**：不必一次遷移所有內容，每月審計逐步優化

---

## 參考

- [官方 Memory 文件](https://code.claude.com/docs/en/memory)
- [本 workspace Memory.md sync 機制](../CLAUDE.md)
- [Hook Lifecycle](./hook-lifecycle.md)
