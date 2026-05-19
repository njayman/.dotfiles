#!/usr/bin/env bash
SSID=$(iwgetid -r 2>/dev/null)
if [ -n "$SSID" ]; then
    echo "󰤨 $SSID"
elif ip route 2>/dev/null | grep -q default; then
    echo "󰈀 wired"
else
    echo "󰤭 offline"
fi
