#!/usr/bin/env bash
if pactl get-source-mute @DEFAULT_SOURCE@ | grep -q yes; then
    echo "󰍭 muted"
else
    VOL=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep -oP '[0-9]+(?=%)' | head -1)
    echo "󰍬 ${VOL}%"
fi
