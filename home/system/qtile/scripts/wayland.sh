#!/usr/bin/env bash

# Background utilities
    wlr-randr --output DP-3 --mode 1920x1080@239.759995
    sleep 1
    wlr-randr --output eDP-1 --off
wl-copy &
waypaper --restore &
#conky --config=/home/array/.config/conky/nord.conkyrc &
# Start dunst and replace shell process
exec dunst
