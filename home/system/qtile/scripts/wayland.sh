#!/usr/bin/env bash

wl-copy &
waypaper --restore &
exec dunst
