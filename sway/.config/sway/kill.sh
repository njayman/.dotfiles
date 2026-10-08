#!/usr/bin/env bash
# foot has no confirm-on-close option, so ask here before killing it
app=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true) | .app_id // empty')
if [ "$app" = "foot" ]; then
  [ "$(printf "No\nYes" | wofi --dmenu --prompt "Close foot?")" = "Yes" ] || exit 0
fi
swaymsg kill
