#!/bin/bash
swaymsg -t get_tree \
    | jq -r 'recurse(.nodes[]?, .floating_nodes[]?) | select(.type=="con" and .pid!=null) | "\(.id) | \(.app_id // .window_properties.class // "app") | \(.name)"' \
    | wofi --dmenu --prompt "Windows" --width 700 --height 400 \
    | sed 's/ |.*//' \
    | xargs -I{} swaymsg "[con_id={}] focus"
