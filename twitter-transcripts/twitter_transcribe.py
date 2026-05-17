#!/usr/bin/env python3
"""
Twitter/X 影片轉 Markdown 逐字稿工具

用法:
    python3 twitter_transcribe.py <tweet_url> [options]

選項:
    --model    Whisper 模型大小 (tiny/base/small/medium/large), 預設 base
    --output   輸出檔案路徑, 預設 transcript.md
    --lang     指定語言 (e.g. zh/en/ar), 預設自動偵測
"""

import argparse
import json
import os
import subprocess
import sys
import tempfile
from pathlib import Path


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

    # Find the actual downloaded file (extension may vary)
    base = output_path.rsplit(".", 1)[0] if "." in output_path else output_path
    for ext in ["mp4", "mp3", "m4a", "webm", "opus"]:
        candidate = f"{base}.{ext}"
        if os.path.exists(candidate):
            return candidate
    # Fallback: find by pattern
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

    kwargs = {"verbose": False}
    if language:
        kwargs["language"] = language

    print(f"[2/3] 轉錄音訊中...")
    return model.transcribe(audio_path, **kwargs)


def build_markdown(result: dict, url: str, model_name: str) -> str:
    """Convert Whisper result to formatted Markdown."""
    lang_map = {
        "en": "英文 (English)", "zh": "中文 (Chinese)",
        "ar": "阿拉伯文 (Arabic)", "ja": "日文 (Japanese)",
        "ko": "韓文 (Korean)", "fr": "法文 (French)",
        "de": "德文 (German)", "es": "西班牙文 (Spanish)",
    }
    lang_code = result.get("language", "unknown")
    lang_display = lang_map.get(lang_code, lang_code)
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


def main():
    parser = argparse.ArgumentParser(description="Twitter/X 影片轉 Markdown 逐字稿")
    parser.add_argument("url", help="Twitter/X 推文網址")
    parser.add_argument("--model", default="base",
                        choices=["tiny", "base", "small", "medium", "large"],
                        help="Whisper 模型大小 (預設: base)")
    parser.add_argument("--output", default="transcript.md", help="輸出 Markdown 檔案")
    parser.add_argument("--lang", default=None, help="指定語言代碼 (e.g. zh/en/ar)")
    parser.add_argument("--keep-audio", action="store_true", help="保留下載的音訊檔")
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
    markdown = build_markdown(result, args.url, args.model)

    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(markdown, encoding="utf-8")

    print(f"\n完成！逐字稿已儲存至: {output_path}")
    print(f"語言: {result.get('language', 'unknown')}")
    print(f"段落數: {len(result.get('segments', []))}")
    print(f"總字數: {len(result['text'].split())}")


if __name__ == "__main__":
    main()
