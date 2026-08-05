#!/usr/bin/env sh

export _JAVA_AWT_WM_NONREPARENTING=1

run() {
	pgrep -x "$1" >/dev/null || "$@" &
}

run xrandr --output eDP-1 --scale 1x1 --mode 2560x1600 --rate 60.00
run sxhkd
run picom
run dunst
run brightnessctl set 60%
run lxpolkit
run xss-lock -- xsecurelock
run polybar
run emacs --daemon
run udiskie
feh --bg-scale ~/nux/wallpapers/5.jpg
