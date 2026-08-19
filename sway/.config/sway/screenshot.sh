#!/bin/bash
exec 9>/tmp/screenshot.lock
flock -n 9 || exit 0

if pgrep -x swappy >/dev/null; then
    swaymsg '[app_id="swappy"] focus'
else
    # swappy's copy action forks a detached `wl-copy` to keep serving the
    # clipboard after swappy exits; without 9>&- it inherits fd 9 and holds
    # the lock for as long as that clipboard offer lives.
    grim -g "$(slurp)" - | swappy -f - 9>&-
fi
