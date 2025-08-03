#!/usr/bin/env bash
GEOMETRY="$(slurp)"
grim -g "${GEOMETRY}" - | wl-copy && notify-send "Screenshot Taken" "Your screenshot has been saved to the clipboard."
