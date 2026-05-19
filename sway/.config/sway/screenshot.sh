#!/bin/bash
flock -n /tmp/screenshot.lock \
    sh -c 'pgrep -x swappy && swaymsg "[app_id=\"swappy\"] focus" || grim -g "$(slurp)" - | swappy -f -'
