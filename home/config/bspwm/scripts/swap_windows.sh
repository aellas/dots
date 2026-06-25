#!/usr/bin/env sh

if [ "$(bspc query -N -n focused)" = "$(bspc query -N -n @/1)" ]; then
    bspc node -s last
else
    bspc node -s @/1
fi
