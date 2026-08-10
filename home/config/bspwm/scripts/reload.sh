#!/usr/bin/env sh

bspc wm -r
sleep 0.5
killall -q polybar
killall -q sxhkd
polybar &
sxhkd &
