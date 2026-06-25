#!/bin/bash

get_governor() {
    powerprofilesctl get
}

set_governor() {
    powerprofilesctl set "$1"
}

case "$1" in
    toggle)
        current=$(get_governor)
        if [ "$current" = "performance" ]; then
            set_governor balanced
        elif [ "$current" = "balanced" ]; then
            set_governor power-saver
        else
            set_governor performance
        fi
        ;;
    *)
        gov=$(get_governor)
        if [ "$gov" = "performance" ]; then
            echo ""
        elif [ "$gov" = "balanced" ]; then
            echo "󰀘"
        else
            echo ""
        fi
        ;;
esac
