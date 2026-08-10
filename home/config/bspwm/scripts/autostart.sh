#!/usr/bin/env sh

export _JAVA_AWT_WM_NONREPARENTING=1

run() {
	pgrep -x "$1" >/dev/null || "$@" &
}

# --- Display ---
run xrandr --output eDP-1 --scale 1x1 --mode 3840x2400 --rate 60.00
run nitrogen --restore
run picom
run brightnessctl set 60%

# --- Core WM services ---
run sxhkd
run polybar
run dunst

# --- System / session ---
run udiskie
run lxpolkit
run xss-lock -- xsecurelock

# --- Apps ---
run emacs --daemon
