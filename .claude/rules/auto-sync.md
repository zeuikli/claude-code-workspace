---
description: Hook 自動化同步機制 — 全部 25 種官方 Hook 事件參考
tier: ondemand
source: "https://code.claude.com/docs/en/hooks"
---

# 自動化同步機制

## 本 Workspace 已啟用的 Hooks

- **SessionStart** — 每次 session 啟動時自動拉取最新的 CLAUDE.md
- **UserPromptSubmit** — 每次 prompt 注入 Sub Agent 委派提醒
- **PreToolUse（matcher: bash）** — commit 前強制執行 `/deep-review`
- **PostToolUse（matcher: Edit|Write）** — 自動驗證 .sh/.json/.py 語法
- **PreCompact / PostCompact** — 壓縮前後提醒確認 Auto Memory
- **SubagentStart / SubagentStop** — 監控 Advisor 策略落實度
- **Stop** — 任務完成通知（音效 / bell）
- **InstructionsLoaded** — 紀錄 CLAUDE.md 與 rules 載入時機

**跨對話記憶**: 由官方 Auto Memory 管理（`autoMemoryEnabled: true`），自動累積於 `~/.claude/projects/<project>/memory/`。

**跨專案共用**: 其他專案的 `.claude/settings.json` 加入相同 SessionStart Hook 即可引用本 workspace。

---

## 官方完整 Hook 事件表（25 種，驗證來源：code.claude.com）

### Session 生命週期
| 事件 | 觸發時機 | 典型用途 |
|------|----------|---------|
| `SessionStart` | Session 啟動或恢復 | 拉取最新設定、環境初始化 |
| `SessionEnd` | Session 結束 | 存檔、清理暫存 |
| `InstructionsLoaded` | CLAUDE.md / rules 載入後 | 記錄版本、除錯載入順序 |

### 每輪事件
| 事件 | 觸發時機 | 典型用途 |
|------|----------|---------|
| `UserPromptSubmit` | 使用者送出 prompt 前 | 注入提醒、前置驗證 |
| `Stop` | Claude 回應完成 | 完成通知（音效 / Slack） |
| `StopFailure` | 輪次因 API 錯誤結束 | 錯誤回報、自動重試 |
| `Notification` | Claude Code 發出通知 | 轉發到外部系統 |

### 工具執行（Agentic Loop）
| 事件 | 觸發時機 | 典型用途 |
|------|----------|---------|
| `PreToolUse` | 工具呼叫執行前 | 安全閘道、格式驗證 |
| `PostToolUse` | 工具呼叫成功後 | 語法檢查、副作用驗證 |
| `PostToolUseFailure` | 工具呼叫失敗後 | 自動補救、錯誤記錄 |
| `PermissionRequest` | 出現 permission dialog | 路由至外部審批系統 |
| `PermissionDenied` | auto mode 拒絕工具呼叫 | 記錄拒絕原因、替代方案 |

### Subagent & 團隊事件
| 事件 | 觸發時機 | 典型用途 |
|------|----------|---------|
| `SubagentStart` | Subagent 啟動 | 監控 Advisor 策略落實 |
| `SubagentStop` | Subagent 結束 | 結果驗證、成本記錄 |
| `TeammateIdle` | Agent team 成員即將閒置 | 重新分配工作 |

### 任務管理事件
| 事件 | 觸發時機 | 典型用途 |
|------|----------|---------|
| `TaskCreated` | TaskCreate 建立任務時 | 任務日誌、通知 |
| `TaskCompleted` | 任務標記為完成時 | 完成通知、品質審查 |

### 檔案與設定事件
| 事件 | 觸發時機 | 典型用途 |
|------|----------|---------|
| `FileChanged` | 監控的檔案在磁碟上變更 | 自動重新載入、lint |
| `CwdChanged` | 工作目錄變更 | 切換專案設定 |
| `ConfigChange` | Session 中設定檔變更 | 熱重載設定 |
| `WorktreeCreate` | Worktree 建立時 | 初始化 worktree 環境 |
| `WorktreeRemove` | Worktree 移除時 | 清理、存檔 |

### Context 壓縮事件
| 事件 | 觸發時機 | 典型用途 |
|------|----------|---------|
| `PreCompact` | Context 壓縮前 | 提醒確認 Auto Memory |
| `PostCompact` | Context 壓縮完成後 | 確認摘要品質 |

### MCP Elicitation 事件
| 事件 | 觸發時機 | 典型用途 |
|------|----------|---------|
| `Elicitation` | MCP server 請求使用者輸入時 | 自動填入或路由審批 |
| `ElicitationResult` | 使用者回應後、送回前 | 驗證或轉換輸入值 |

---

## Hook exit code 規約（官方 + 社群驗證）

| Exit Code | 效果 |
|-----------|------|
| `0` | 成功，繼續執行 |
| `1` | 警告，繼續執行（輸出顯示給使用者）|
| `2` | **阻斷**，停止工具執行 + 回饋錯誤訊息給 Claude |
