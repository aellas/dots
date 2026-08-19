#!/usr/bin/env sh

export _JAVA_AWT_WM_NONREPARENTING=1

run() {
	pgrep -x "$1" >/dev/null || "$@" &
}

# --- Display ---
run xrandr --output eDP-1 --mode 3840x2400 --rate 60.00
run xrandr --output HDMI-1 --mode 1920x1080 --rate 239.76
run nitrogen --restore
run picom --config ~/.config/picom/picom.conf --vsync
run brightnessctl set 60%

# --- Core WM services ---
run sxhkd
run snixembed
run polybar
run dunst

# --- System / session ---
run udiskie
run lxpolkit
run skippy-xd --start-daemon

# --- Apps ---
run emacs --daemon
