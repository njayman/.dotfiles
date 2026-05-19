#!/usr/bin/env bash
BAT=$(ls /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
[[ -z "$BAT" ]] && exit 0

CAP=$(cat "$BAT")
STATUS=$(cat "${BAT/capacity/status}" 2>/dev/null)

if [[ "$STATUS" == "Charging" ]]; then
    ICON="󰂄"
elif [[ "$CAP" -gt 80 ]]; then
    ICON="󰁹"
elif [[ "$CAP" -gt 60 ]]; then
    ICON="󰂀"
elif [[ "$CAP" -gt 40 ]]; then
    ICON="󰁾"
elif [[ "$CAP" -gt 20 ]]; then
    ICON="󰁼"
else
    ICON="󰁺"
fi

echo "${CAP}%  ${ICON}"
