#!/usr/bin/env bash

wl-copy &
waypaper --restore &
exec dunst &
(sleep 1 && way-displays) &
