# Hook 生命週期視覺化

> 此 workspace 共 10 個 hook 腳本對應 7 種 Claude Code 事件。本文以 Mermaid 圖示完整觸發順序與依賴。
> tags: [hooks, lifecycle, mermaid, debugging]

---

## 完整生命週期 sequenceDiagram

```mermaid
sequenceDiagram
    autonumber
    participant U as 使用者
    participant CC as Claude Code
    participant H as Hooks 系統
    participant FS as 檔案系統
    participant Git as GitHub

    Note over U,Git: 1️⃣ Session 啟動階段
    U->>CC: 開啟對話 / claude
    CC->>H: SessionStart 事件
    H->>H: session-init.sh<br/>(git fetch + reset + log elapsed)
    H->>FS: 寫入 ~/.claude/CLAUDE.md
    CC->>H: InstructionsLoaded 事件
    H->>FS: instructions-loaded.sh<br/>append ~/.claude/instructions-load.log

    Note over U,Git: 2️⃣ 主對話迴圈（每輪）
    loop 每次工具呼叫
        U->>CC: 輸入 prompt
        CC->>H: PreToolUse(read) 事件
        H->>H: memory-pull.sh<br/>(JSON additionalContext 注入摘要)
        CC->>H: PreToolUse(bash) 事件
        H->>H: pre-commit-review.sh<br/>(git commit 前提醒 deep-review)
        CC->>FS: 執行工具（Read/Edit/Write/Bash）
        CC->>H: PostToolUse(write|edit) 事件
        H->>H: memory-update-hook.sh<br/>(30s throttle + 觸發 sync)
        H-->>+Git: memory-sync.sh (背景，flock 序列化)
        Git-->>-H: push 結果
    end

    Note over U,Git: 3️⃣ Compaction 事件（context 接近上限）
    CC->>H: PreCompact 事件
    H->>H: pre-compact.sh<br/>(JSON additionalContext 提醒更新 Memory.md)
    CC->>CC: 執行壓縮
    CC->>H: PostCompact 事件
    H->>H: post-compact.sh<br/>(JSON additionalContext 提示恢復)

    Note over U,Git: 4️⃣ Session 結束
    U->>CC: 關閉對話 / Stop
    CC->>H: Stop 事件
    H->>H: session-stop.sh
    H-->>+Git: 呼叫 memory-sync.sh (flock 序列化，等待背景任務)
    Git-->>-H: 最終 push 完成
```

---

## Hook 觸發矩陣

| Hook 腳本 | 對應事件 | matcher | 行為 |
|---|---|---|---|
| `session-init.sh` | `SessionStart` | `""` | git fetch + reset；建立 `~/.claude/CLAUDE.md` |
| `instructions-loaded.sh` | `InstructionsLoaded` | `""` | log 載入時機到 `~/.claude/instructions-load.log` |
| `memory-pull.sh` | `PreToolUse` | `read` | git fetch Memory.md + JSON additionalContext 注入 |
| `pre-commit-review.sh` | `PreToolUse` | `bash` | 偵測 git commit 命令時提醒 deep-review |
| `memory-update-hook.sh` | `PostToolUse` | `write\|edit` | 30s throttle + 背景觸發 memory-sync |
| `memory-sync.sh` | （由其他 hook 呼叫） | — | flock 序列化 + git commit + push（重試 4 次） |
| `memory-archive.sh` | （手動或排程） | — | Memory.md > 200 行 / 25KB 時自動歸檔 |
| `pre-compact.sh` | `PreCompact` | `""` | JSON additionalContext 提醒寫 Memory.md |
| `post-compact.sh` | `PostCompact` | `""` | JSON additionalContext 提示從 Memory 恢復 |
| `session-stop.sh` | `Stop` | `""` | 觸發 memory-sync 確保最終 push |

---

## 競態條件防護

```mermaid
flowchart TD
    A[Memory.md 被 Edit/Write] --> B{30s 內<br/>已 sync?}
    B -->|是| C[memory-update-hook<br/>直接跳過]
    B -->|否| D[更新 lockfile timestamp]
    D --> E["memory-sync.sh & (背景)"]
    F[Stop 事件] --> G[session-stop.sh]
    G --> H[同步呼叫 memory-sync.sh]
    E --> I{flock 200>lock?}
    H --> I
    I -->|首個獲得| J[執行 git push]
    I -->|其他等待| K[exit 0 跳過]
    J --> L[釋放 lock]
```

**雙重保護**：
1. **30s throttle**（時間維度）— 避免高頻寫入觸發過多 sync
2. **flock**（程序維度）— 確保同一時間只有一個 git push 在執行，避免 race condition

---

## 除錯指南

### 確認 hook 有觸發
```bash
# 查看 instructions 載入紀錄
tail ~/.claude/instructions-load.log

# 查看壓縮事件紀錄
tail ~/.claude/compact-events.log

# 查看 sync lockfile 時間
date -d @"$(cat ~/.claude/.memory-sync-lockfile 2>/dev/null)"

# 測試單一 hook
bash .claude/hooks/session-init.sh
```

### 常見問題

| 症狀 | 可能原因 | 解法 |
|---|---|---|
| Memory.md 未自動 push | 30s throttle 內 / flock 已被佔 | 等 30s 或手動 `bash .claude/hooks/memory-sync.sh` |
| `session-init` 變慢 | repo > 5MB 卻未用 filter / 反之 | 檢查 `du -sb .git`，調整 `SIZE_THRESHOLD_BYTES` |
| Hook 命名錯誤 | 拼錯 `InstructionsLoaded` 等 | 對照官方 [Hooks 文件](https://code.claude.com/docs/en/hooks) 完整事件清單 |
| Compact hook 沒觸發 | Claude Code 版本 < v2.x | 升級 `claude --upgrade` |

---

## 擴充建議

未實作但可考慮的官方事件：
- `UserPromptSubmit` — 使用者每次按 Enter（注入 context 黃金時機）
- `SubagentStart` / `SubagentStop` — 監控 sub agent 執行狀態
- `FileChanged` — 比 PostToolUse(write|edit) 更精準的事件
- `WorktreeCreate` / `WorktreeRemove` — 配合 `isolation: worktree` 使用
- `SessionEnd` — 比 `Stop` 更精準的結束事件
