#!/bin/bash
# ghostty ignores app_id values without a dot (falls back to the default
# app_id), so "clipse" alone never matched the for_window rule; use a
# dotted id so both matching and this singleton check work.
app_id=com.dotfiles.clipse

if swaymsg -t get_tree | jq -e --arg id "$app_id" \
    'first(recurse(.nodes[]?, .floating_nodes[]?) | select(.app_id == $id))' >/dev/null; then
    swaymsg "[app_id=\"$app_id\"] focus"
else
    exec ghostty --class="$app_id" -e clipse
fi
