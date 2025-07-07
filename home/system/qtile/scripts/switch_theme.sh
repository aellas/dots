#!/usr/bin/env bash

WALLPAPER_DIR="/home/array/Documents/GitHub/nixos-testing/home/system/qtile/wallpapers/"
SELECTED=$(find "$WALLPAPER_DIR" -type f | sort | rofi -dmenu -i -p "Select Wallpaper")

[ -z "$SELECTED" ] && exit 1

feh --bg-fill "$SELECTED"

wal -i "$SELECTED"

qtile cmd-obj -o cmd -f reload_config

bash dunst.sh