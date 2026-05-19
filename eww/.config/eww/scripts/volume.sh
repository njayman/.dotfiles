#!/usr/bin/env bash
if pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes; then
    echo "󰖁 muted"
else
    VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '[0-9]+(?=%)' | head -1)
    echo "󰕾 ${VOL}%"
fi
