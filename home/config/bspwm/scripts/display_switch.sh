#!/usr/bin/env sh

LAPTOP="eDP-1"
MONITOR="HDMI-1"

LAPTOP_MODE="--mode 3840x2400 --rate 60.00"
MONITOR_MODE="--mode 1920x1080 --rate 239.76"

export DISPLAY=:0
export XAUTHORITY=/home/$(whoami)/.Xauthority

if xrandr | grep "$MONITOR connected"; then
	xrandr --output "$MONITOR" $MONITOR_MODE --primary --output "$LAPTOP" --off
else
	xrandr --output "$LAPTOP" $LAPTOP_MODE --primary --output "$MONITOR" --off
fi
