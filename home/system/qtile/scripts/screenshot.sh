#!/bin/bash

# Prompt options
options="󰹑  Fullscreen\n󰨵  Region"

# Show menu and capture selection
choice=$(echo -e "$options" | rofi -dmenu -p "Screenshot")

# Set output directory and filename
output_dir="${HOME}/Pictures/Screenshots"
mkdir -p "$output_dir"
filename="screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
output_path="${output_dir}/${filename}"

case "$choice" in
    "󰹑  Fullscreen")
        grim "$output_path" && wl-copy < "$output_path"
        notify-send "Screenshot saved" "$output_path"
        ;;
    "󰨵  Region")
        slurp | grim -g - "$output_path" && wl-copy < "$output_path"
        notify-send "Screenshot (selection) saved" "$output_path"
        ;;
    *)
        exit 1
        ;;
esac
