#!/usr/bin/env bash
GEOMETRY="$(slurp)"
grim -g "${GEOMETRY}" - | wl-copy
