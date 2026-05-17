# Skill: twitter-transcribe

**觸發詞**: `/twitter-transcribe`, `抓推文影片`, `X影片轉逐字稿`, `Twitter影片轉錄`

## 用途

從 Twitter/X 推文網址下載影片（或音訊），透過 OpenAI Whisper 語音辨識，產出含時間戳的 Markdown 逐字稿。

## 前置需求

```bash
pip install yt-dlp openai-whisper
apt-get install -y ffmpeg   # 或 brew install ffmpeg
```

## 使用方式

### 選項 1：直接叫用腳本

```bash
python3 twitter-transcripts/twitter_transcribe.py <tweet_url> [options]
```

**選項**:
| 選項 | 說明 | 預設 |
|------|------|------|
| `--model` | Whisper 模型 (`tiny`/`base`/`small`/`medium`/`large`) | `base` |
| `--output` | 輸出 Markdown 路徑 | `transcript.md` |
| `--lang` | 指定語言代碼 (`zh`/`en`/`ar`…) | 自動偵測 |
| `--keep-audio` | 保留下載的音訊檔 | 否 |

**範例**:
```bash
# 基本用法
python3 twitter-transcripts/twitter_transcribe.py "https://x.com/user/status/123"

# 指定大模型 + 輸出路徑
python3 twitter-transcripts/twitter_transcribe.py "https://x.com/user/status/123" \
  --model small --output transcripts/output.md

# 指定語言（加快辨識速度）
python3 twitter-transcripts/twitter_transcribe.py "https://x.com/user/status/123" \
  --lang en
```

### 選項 2：透過 Claude Code 指令

說「/twitter-transcribe <url>」或「幫我把這個 Twitter 影片轉成逐字稿：<url>」

Claude 會自動：
1. 用 yt-dlp 下載音訊（`--no-check-certificate` 因雲端 SSL 環境）
2. 用 Whisper 語音辨識
3. 產出含時間戳的 Markdown 逐字稿
4. Commit 並 push 結果

## 輸出格式

```markdown
# Twitter 影片逐字稿

**來源**: https://x.com/...
**語言**: 英文 (English)
**語音辨識模型**: OpenAI Whisper (base)
**片段數**: 174

---

## 逐字稿（含時間戳）

**[00:00 → 00:16]** Hello, everyone. I'm Boris...

**[00:16 → 00:21]** And here to talk to you...

---

## 完整純文字

Hello, everyone. I'm Boris...
```

## 模型選擇建議

| 模型 | 速度 | 精準度 | 適用情境 |
|------|------|------|---------|
| `tiny` | 最快 | 較低 | 快速預覽、短片 |
| `base` | 快 | 中等 | **日常使用（推薦）** |
| `small` | 中等 | 良好 | 需要更高精準度 |
| `medium` | 慢 | 高 | 技術內容、專業術語 |
| `large` | 最慢 | 最高 | 高品質需求、多語言混合 |

> CPU 環境下 `base` 約 2 分鐘處理 30 分鐘影片；`large` 會慢 5-10 倍。

## 注意事項

- yt-dlp 需使用 `--no-check-certificate` 以繞過雲端環境 SSL 問題
- Whisper 在 CPU 環境自動使用 FP32（不影響結果，僅速度稍慢）
- 私人推文或地區限制影片無法下載
- 逐字稿儲存於 `twitter-transcripts/` 目錄
