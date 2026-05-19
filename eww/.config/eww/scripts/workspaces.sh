#!/usr/bin/env bash

emit() {
  swaymsg -t get_workspaces | jq -c '
    . as $ws |
    [range(1;11)] | map(. as $n |
      ($ws | map(select(.num == $n)) | first) as $w |
      {
        num: $n,
        state: (
          if $w == null then "empty"
          elif $w.focused then "focused"
          elif $w.urgent then "urgent"
          else "occupied"
          end
        )
      }
    )'
}

emit

while true; do
  swaymsg -t subscribe '["workspace","window"]' |
  while IFS= read -r _; do
    sleep 0.05
    emit
  done

done
