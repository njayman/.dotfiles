#!/bin/bash
jq -r '
  to_entries[] |
  "── \(.key) ──",
  (.value[] | select(.hidden != true) |
    "  \(.key | gsub("\\$mod"; "Super") | gsub("\\$term"; "ghostty") | gsub("\\$menu"; "wofi"))   \(.desc)")
' ~/.config/sway/keybinds.json \
| wofi --dmenu --prompt "󰌌 Keybinds" --width 750 --height 600 --no-actions --insensitive
