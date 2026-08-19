#!/usr/bin/env sh
# scratchpad — toggle a class-tagged wezterm window.
# Usage: scratchpad [class] [command]

CLASS="${1:-scratchpad-terminal}"
CMD="${2:-}"

id=$(xdotool search --class "$CLASS" | head -n1)

if [ -z "$id" ]; then
	if [ -n "$CMD" ]; then
		wezterm start --class "$CLASS" -e $CMD &
	else
		wezterm start --class "$CLASS" &
	fi
else
	bspc node "$id" -g hidden -f
fi
