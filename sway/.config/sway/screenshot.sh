#!/bin/bash
exec 9>/tmp/screenshot.lock
flock -n 9 || exit 0

if pgrep -x satty >/dev/null; then
    swaymsg '[app_id="(?i)satty"] focus'
else
    # ponytail: flatpak build, the release binary needs glibc 2.43 (24.04 has 2.39)
    # 9>&- keeps the editor from inheriting and holding the lock fd.
    mkdir -p ~/Pictures/Screenshots
    grim -g "$(slurp)" - | flatpak run org.satty.Satty --filename - \
        --output-filename ~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png 9>&-
fi
