#!/usr/bin/env bash

# Screenshot save path
dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
img_path="$dir/screenshot-$(date +%F_%H-%M-%S).png"

# Select region, capture, annotate
slurp | grim -g - "$img_path" || exit 1
swappy -f "$img_path" -o "$img_path"

# Copy to clipboard
wl-copy < "$img_path"

# Notify (optional)
notify-send "📸 Screenshot saved and copied"
