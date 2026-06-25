#!/usr/bin/env sh

export _JAVA_AWT_WM_NONREPARENTING=1
run() {
	pgrep -x "$1" >/dev/null || "$@" &
}

xrandr --output eDP-1 --scale 1x1 --mode 2560x1600 --rate 60.00
run sxhkd
run picom
run nitrogen --restore
run dunst
run brightnessctl set 60%
run polybar
run xsetroot -cursor_name Bibata-Modern-Ice_left_ptr
run gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
run skippy-xd --start-daemon
run lxpolkit
run emacs --daemon
