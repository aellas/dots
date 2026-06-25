#!/usr/bin/env bash

SCREENSHOT_DIR="${SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="screenshot_${DATE}.png"
OUTPUT="${SCREENSHOT_DIR}/${FILENAME}"

# Ensure the output directory exists
mkdir -p "$SCREENSHOT_DIR"

# ── Rofi menu ────────────────────────────────────────────────────────────────
CHOICE=$(printf "Fullscreen\n  Region\n  Window" \
    | rofi -dmenu \
           -i \
           -p "" \
           -theme-str 'window {width: 300px; height: 300px;}' \
           -no-custom)

case "$CHOICE" in
    "Fullscreen")
        # Small delay so the rofi window has time to close
        sleep 0.3
        scrot "$OUTPUT"
        ;;
    "  Region")
        sleep 0.3
        # -s = select region by drawing a rectangle
        # --line draws a visible red selection box (style,width,color,opacity,mode)
        scrot -s --line style=dash,width=3,color="white",opacity=180,mode=edge "$OUTPUT"
        ;;
    "  Window")
        sleep 0.3
        # -u = focused window, -b = include window border
        scrot -ub "$OUTPUT"
        ;;
    *)
        # User cancelled or pressed Escape
        exit 0
        ;;
esac

# ── Post-capture actions ──────────────────────────────────────────────────────
if [[ -f "$OUTPUT" ]]; then
    # Copy to clipboard if xclip is available
    if command -v xclip &>/dev/null; then
        xclip -selection clipboard -target image/png -i "$OUTPUT"
        CLIP_MSG=" — copied to clipboard"
    fi

    # Desktop notification if notify-send is available
    if command -v notify-send &>/dev/null; then
        notify-send "Screenshot saved${CLIP_MSG:-}" "$OUTPUT" \
            --icon="$OUTPUT" \
            --expire-time=4000
    fi
fi
