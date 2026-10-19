#!/bin/bash
app_id=com.dotfiles.clipse

if swaymsg -t get_tree | jq -e --arg id "$app_id" \
    'first(recurse(.nodes[]?, .floating_nodes[]?) | select(.app_id == $id))' >/dev/null; then
    swaymsg "[app_id=\"$app_id\"] focus"
else
    exec wezterm start --class "$app_id" -- ~/go/bin/clipse
fi
