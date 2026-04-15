#!/bin/bash
# caveman — statusline badge script for Claude Code
# Reads the caveman mode flag file and outputs a colored badge.
# Supports: full/lite/ultra/wenyan-* + auto:* prefix from auto-classifier
#
# Usage in ~/.claude/settings.json:
#   "statusLine": { "type": "command", "command": "bash /path/to/caveman-statusline.sh" }

FLAG="$HOME/.claude/.caveman-active"
[ ! -f "$FLAG" ] && exit 0

MODE=$(cat "$FLAG" 2>/dev/null)
[ -z "$MODE" ] && exit 0

# Handle auto:* prefix (e.g. auto:ultra, auto:lite, auto:full)
if [[ "$MODE" == auto:* ]]; then
  SUBLEVEL="${MODE#auto:}"
  if [ "$SUBLEVEL" = "full" ] || [ -z "$SUBLEVEL" ]; then
    # auto full = show [CAVEMAN:AUTO]
    printf '\033[38;5;33m[CAVEMAN:AUTO]\033[0m'
  else
    SUFFIX=$(echo "$SUBLEVEL" | tr '[:lower:]' '[:upper:]')
    # auto ultra = blue [CAVEMAN:AUTO:ULTRA], auto lite = green [CAVEMAN:AUTO:LITE]
    case "$SUBLEVEL" in
      ultra) printf '\033[38;5;196m[CAVEMAN:AUTO:%s]\033[0m' "$SUFFIX" ;;  # red = ultra
      lite)  printf '\033[38;5;46m[CAVEMAN:AUTO:%s]\033[0m'  "$SUFFIX" ;;  # green = lite
      *)     printf '\033[38;5;33m[CAVEMAN:AUTO:%s]\033[0m'  "$SUFFIX" ;;  # blue = other auto
    esac
  fi
elif [ "$MODE" = "full" ]; then
  printf '\033[38;5;172m[CAVEMAN]\033[0m'
else
  SUFFIX=$(echo "$MODE" | tr '[:lower:]' '[:upper:]')
  printf '\033[38;5;172m[CAVEMAN:%s]\033[0m' "$SUFFIX"
fi
