#!/usr/bin/env python3
"""
Twitter/X 影片轉 Markdown 逐字稿工具

用法:
    python3 twitter_transcribe.py <tweet_url> [options]

選項:
    --model      Whisper 模型大小 (tiny/base/small/medium/large), 預設 base
    --output     輸出逐字稿路徑, 預設 transcript.md
    --lang       指定語言 (e.g. zh/en/ar), 預設自動偵測
    --summarize  額外產出核心摘要 Markdown（需設定 ANTHROPIC_API_KEY）
    --summary-output  摘要輸出路徑, 預設 summary.md
    --summary-lang    摘要輸出語言, 預設 zh-TW（繁體中文）
    --keep-audio 保留下載的音訊檔
"""

import argparse
import json
import os
import subprocess
import sys
import tempfile
from pathlib import Path


LANG_MAP = {
    "en": "英文 (English)", "zh": "中文 (Chinese)",
    "ar": "阿拉伯文 (Arabic)", "ja": "日文 (Japanese)",
    "ko": "韓文 (Korean)", "fr": "法文 (French)",
    "de": "德文 (German)", "es": "西班牙文 (Spanish)",
}

SUMMARY_SYSTEM_PROMPT = """\
你是一位專業的技術內容摘要員。請根據提供的影片逐字稿，產出一份結構清晰、適合研究引用的核心摘要。

摘要要求：
1. 開頭提供「一句話總結」
2. 按主題分段，每段附時間戳參考
3. 重要論點用引言或表格呈現
4. 包含可直接使用的指令範例（如有）
5. 結尾附「技術選型小結」表格（如適用）
6. 使用 Markdown 格式
7. 盡量保留原始數據（百分比、時間、版本號等）

注意：Whisper 語音辨識可能有誤字，請根據上下文修正明顯的產品名稱或技術術語。
"""


def format_time(seconds: float) -> str:
    m, s = divmod(int(seconds), 60)
    h, m = divmod(m, 60)
    if h > 0:
        return f"{h:02d}:{m:02d}:{s:02d}"
    return f"{m:02d}:{s:02d}"


def download_video(url: str, output_path: str) -> str:
    """Download video/audio from Twitter/X URL using yt-dlp."""
    cmd = [
        "yt-dlp",
        url,
        "--format", "bestaudio/best",
        "-o", output_path,
        "--no-check-certificate",
        "--quiet",
        "--no-warnings",
    ]
    print(f"[1/3] 下載影片: {url}")
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError(f"yt-dlp 下載失敗:\n{result.stderr}")

    base = output_path.rsplit(".", 1)[0] if "." in output_path else output_path
    for ext in ["mp4", "mp3", "m4a", "webm", "opus"]:
        candidate = f"{base}.{ext}"
        if os.path.exists(candidate):
            return candidate
    parent = Path(output_path).parent
    stem = Path(output_path).stem
    matches = list(parent.glob(f"{stem}.*"))
    if matches:
        return str(matches[0])
    raise FileNotFoundError("下載完成但找不到輸出檔案")


def transcribe(audio_path: str, model_name: str = "base", language: str | None = None) -> dict:
    """Transcribe audio using OpenAI Whisper."""
    try:
        import whisper
    except ImportError:
        raise ImportError("請先安裝 openai-whisper: pip install openai-whisper")

    print(f"[2/3] 載入 Whisper 模型: {model_name}")
    model = whisper.load_model(model_name)

    kwargs: dict = {"verbose": False}
    if language:
        kwargs["language"] = language

    print("[2/3] 轉錄音訊中...")
    return model.transcribe(audio_path, **kwargs)


def build_transcript_markdown(result: dict, url: str, model_name: str) -> str:
    """Convert Whisper result to timestamped Markdown transcript."""
    lang_code = result.get("language", "unknown")
    lang_display = LANG_MAP.get(lang_code, lang_code)
    segments = result.get("segments", [])

    lines = [
        "# Twitter 影片逐字稿",
        "",
        f"**來源**: {url}",
        f"**語言**: {lang_display}",
        f"**語音辨識模型**: OpenAI Whisper ({model_name})",
        f"**片段數**: {len(segments)}",
        "",
        "---",
        "",
        "## 逐字稿（含時間戳）",
        "",
    ]

    for seg in segments:
        start = format_time(seg["start"])
        end = format_time(seg["end"])
        text = seg["text"].strip()
        lines.append(f"**[{start} → {end}]** {text}")
        lines.append("")

    lines += [
        "---",
        "",
        "## 完整純文字",
        "",
        result["text"].strip(),
    ]

    return "\n".join(lines)


def generate_summary(
    transcript_text: str,
    url: str,
    output_lang: str = "zh-TW",
) -> str:
    """Call Claude API to generate a structured summary of the transcript."""
    try:
        import anthropic
    except ImportError:
        raise ImportError("請先安裝 anthropic SDK: pip install anthropic")

    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        raise EnvironmentError("請設定環境變數 ANTHROPIC_API_KEY")

    lang_instruction = {
        "zh-TW": "請用繁體中文撰寫摘要。",
        "zh-CN": "请用简体中文撰写摘要。",
        "en": "Please write the summary in English.",
        "ja": "日本語で要約を書いてください。",
    }.get(output_lang, f"Please write the summary in {output_lang}.")

    client = anthropic.Anthropic(api_key=api_key)

    user_message = f"""{lang_instruction}

來源推文：{url}

以下是影片逐字稿：

{transcript_text}
"""

    print("[摘要] 呼叫 Claude API 生成核心摘要...")
    response = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=4096,
        system=SUMMARY_SYSTEM_PROMPT,
        messages=[{"role": "user", "content": user_message}],
    )

    summary_body = response.content[0].text

    header = [
        "# 核心摘要",
        "",
        f"**來源**: {url}",
        f"**逐字稿**: [transcript.md](./transcript.md)",
        f"**摘要模型**: claude-sonnet-4-6",
        "",
        "---",
        "",
    ]
    return "\n".join(header) + summary_body


def main():
    parser = argparse.ArgumentParser(description="Twitter/X 影片轉 Markdown 逐字稿（含摘要）")
    parser.add_argument("url", help="Twitter/X 推文網址")
    parser.add_argument("--model", default="base",
                        choices=["tiny", "base", "small", "medium", "large"],
                        help="Whisper 模型大小 (預設: base)")
    parser.add_argument("--output", default="transcript.md", help="逐字稿輸出路徑")
    parser.add_argument("--lang", default=None, help="音訊語言代碼 (e.g. zh/en/ar)")
    parser.add_argument("--keep-audio", action="store_true", help="保留下載的音訊檔")
    parser.add_argument("--summarize", action="store_true",
                        help="額外產出核心摘要（需設定 ANTHROPIC_API_KEY）")
    parser.add_argument("--summary-output", default="summary.md", help="摘要輸出路徑")
    parser.add_argument("--summary-lang", default="zh-TW",
                        help="摘要輸出語言 (zh-TW/zh-CN/en/ja，預設 zh-TW)")
    args = parser.parse_args()

    with tempfile.TemporaryDirectory() as tmpdir:
        audio_path_template = os.path.join(tmpdir, "audio.mp4")

        try:
            audio_file = download_video(args.url, audio_path_template)
            size_mb = os.path.getsize(audio_file) / 1024 / 1024
            print(f"    檔案大小: {size_mb:.1f} MB")
        except Exception as e:
            print(f"錯誤: {e}", file=sys.stderr)
            sys.exit(1)

        try:
            result = transcribe(audio_file, args.model, args.lang)
        except Exception as e:
            print(f"錯誤: {e}", file=sys.stderr)
            sys.exit(1)

        if args.keep_audio:
            import shutil
            dest = Path(args.output).stem + Path(audio_file).suffix
            shutil.copy(audio_file, dest)
            print(f"    音訊已儲存: {dest}")

    print("[3/3] 生成 Markdown 逐字稿...")
    transcript_md = build_transcript_markdown(result, args.url, args.model)

    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(transcript_md, encoding="utf-8")
    print(f"    逐字稿已儲存: {output_path}")

    if args.summarize:
        try:
            summary_md = generate_summary(result["text"], args.url, args.summary_lang)
            summary_path = Path(args.summary_output)
            summary_path.parent.mkdir(parents=True, exist_ok=True)
            summary_path.write_text(summary_md, encoding="utf-8")
            print(f"    核心摘要已儲存: {summary_path}")
        except Exception as e:
            print(f"摘要生成失敗（逐字稿仍可用）: {e}", file=sys.stderr)

    print(f"\n完成！")
    print(f"語言: {result.get('language', 'unknown')}")
    print(f"段落數: {len(result.get('segments', []))}")
    print(f"總字數: {len(result['text'].split())}")


if __name__ == "__main__":
    main()
