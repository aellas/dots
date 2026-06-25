#!/usr/bin/env bash

BT_STATUS=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [ "$BT_STATUS" = "yes" ]; then
    CONNECTED=$(bluetoothctl info | grep "Connected: yes")
    if [ -n "$CONNECTED" ]; then
        DEVICE=$(bluetoothctl info | grep "Name:" | cut -d' ' -f2-)
        echo "󰂰"
    else
        echo "󰂯"
    fi
else
    echo "󰂲"
fi
