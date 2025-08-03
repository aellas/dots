#!/usr/bin/env bash

# Directory containing wallpapers
WALLPAPER_DIR="/home/$USER/Documents/GitHub/nixos-testing/home/system/qtile/wallpapers/"

# Use rofi to select a wallpaper
SELECTED=$(find "$WALLPAPER_DIR" -type f | sort | rofi -dmenu -i -p "Select Wallpaper")

# Exit if no selection made
[ -z "$SELECTED" ] && exit 1

# Set wallpaper using feh
swaybg --image "$SELECTED"
