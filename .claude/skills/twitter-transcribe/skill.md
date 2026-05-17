# Skill: twitter-transcribe

**觸發詞**: `/twitter-transcribe`, `抓推文影片`, `X影片轉逐字稿`, `Twitter影片轉錄`, `推文摘要`

## 用途

從 Twitter/X 推文網址下載影片（或音訊），透過 OpenAI Whisper 語音辨識，產出：
1. **含時間戳的 Markdown 逐字稿**（`transcript.md`）
2. **結構化核心摘要**（`summary.md`，需設定 `ANTHROPIC_API_KEY`）

---

## 前置需求

```bash
pip install yt-dlp openai-whisper anthropic
apt-get install -y ffmpeg   # 或 brew install ffmpeg
```

---

## 使用方式

### 選項 1：直接叫用腳本

```bash
# 基本用法（只產逐字稿）
python3 twitter-transcripts/twitter_transcribe.py "https://x.com/user/status/ID"

# 同時產出核心摘要（繁體中文）
python3 twitter-transcripts/twitter_transcribe.py "URL" \
  --summarize \
  --summary-lang zh-TW

# 指定模型 + 輸出路徑
python3 twitter-transcripts/twitter_transcribe.py "URL" \
  --model small \
  --output transcripts/output.md \
  --summary-output transcripts/summary.md

# 指定音訊語言（加快 Whisper 辨識速度）
python3 twitter-transcripts/twitter_transcribe.py "URL" --lang en
```

### 選項 2：透過 Claude Code 指令

說「幫我把這個 Twitter 影片轉成逐字稿加摘要：`<url>`」

Claude 會自動：
1. 用 yt-dlp 下載音訊（`--no-check-certificate` 適用雲端 SSL 環境）
2. 用 Whisper 語音辨識
3. 產出含時間戳的 Markdown 逐字稿
4. 用 Claude API 生成結構化核心摘要
5. Commit 並 push 所有結果

---

## 完整 CLI 選項

| 選項 | 說明 | 預設值 |
|------|------|--------|
| `url` | Twitter/X 推文網址（必填） | — |
| `--model` | Whisper 模型 | `base` |
| `--output` | 逐字稿輸出路徑 | `transcript.md` |
| `--lang` | 音訊語言代碼（加速辨識） | 自動偵測 |
| `--keep-audio` | 保留下載的音訊檔 | 否 |
| `--summarize` | 額外產出核心摘要 | 否 |
| `--summary-output` | 摘要輸出路徑 | `summary.md` |
| `--summary-lang` | 摘要語言（`zh-TW`/`zh-CN`/`en`/`ja`） | `zh-TW` |

---

## 輸出格式

### 逐字稿（`transcript.md`）

```markdown
# Twitter 影片逐字稿

**來源**: https://x.com/...
**語言**: 英文 (English)
**語音辨識模型**: OpenAI Whisper (base)
**片段數**: 174

---

## 逐字稿（含時間戳）

**[00:00 → 00:16]** Hello, everyone. I'm Boris...

---

## 完整純文字

Hello, everyone. I'm Boris...
```

### 核心摘要（`summary.md`）

```markdown
# 核心摘要

**來源**: https://x.com/...
**逐字稿**: transcript.md
**摘要模型**: claude-sonnet-4-6

---

## 一句話總結
> ...

## 主要重點
...（依內容結構分段，含時間戳參考、指令範例、表格等）
```

---

## Whisper 模型選擇建議

| 模型 | 速度 | 精準度 | 適用情境 |
|------|------|--------|---------|
| `tiny` | 最快 | 較低 | 快速預覽、短片 |
| `base` | 快 | 中等 | **日常使用（推薦）** |
| `small` | 中等 | 良好 | 需要更高精準度 |
| `medium` | 慢 | 高 | 技術內容、專業術語 |
| `large` | 最慢 | 最高 | 高品質需求、多語言混合 |

> CPU 環境下 `base` 約 2 分鐘處理 30 分鐘影片；`large` 慢 5-10 倍。

---

## 注意事項

- yt-dlp 需使用 `--no-check-certificate` 繞過雲端 SSL 問題
- Whisper 在 CPU 環境自動使用 FP32（不影響精準度，僅速度稍慢）
- 私人推文或地區限制影片無法下載
- 產品名稱可能被 Whisper 誤辨識（如 "Claude Code" → "Quad Code"），摘要會自動修正
- `--summarize` 需設定 `ANTHROPIC_API_KEY` 環境變數

---

## 示範案例

- **逐字稿**: `twitter-transcripts/transcript.md`
- **核心摘要**: `twitter-transcripts/summary.md`
- **來源**: Boris Cherny（Claude Code 創作者）實用技巧演講
