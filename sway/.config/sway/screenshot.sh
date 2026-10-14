#!/bin/bash
# Usage: screenshot.sh [satty|swappy|flameshot]   (default: flameshot)
exec 9>/tmp/screenshot.lock
flock -n 9 || exit 0

editor="${1:-flameshot}"
dir=~/Pictures/Screenshots
mkdir -p "$dir"

# Already open? Focus it instead of taking another shot.
swaymsg "[app_id=\"(?i)$editor\"] focus" >/dev/null 2>&1 && exit 0

# 9>&- keeps the editor from inheriting and holding the lock fd.
case "$editor" in
    flameshot)
        # flameshot's own clipboard copy is lost on sway. saveAfterCopy=true
        # (~/.config/flameshot/flameshot.ini) makes Copy also write a file,
        # so put whatever new file appeared on the clipboard via wl-copy.
        mark=$(mktemp)
        flameshot gui -p "$dir" 9>&-
        new=$(find "$dir" -maxdepth 1 -name '*.png' -newer "$mark" | sort | tail -1)
        rm -f "$mark"
        [ -n "$new" ] && wl-copy -t image/png < "$new" 9>&-
        ;;
    swappy)
        # swappy copies via wl-copy itself, so the clipboard survives closing it
        grim -g "$(slurp)" - | swappy -f - -o "$dir/$(date +%Y-%m-%d_%H-%M-%S).png" 9>&-
        ;;
    *)
        # ponytail: flatpak build, the release binary needs glibc 2.43 (24.04 has 2.39)
        # Copy through host wl-copy so the clipboard survives closing satty
        # (needs: flatpak override --user --talk-name=org.freedesktop.Flatpak org.satty.Satty)
        grim -g "$(slurp)" - | flatpak run org.satty.Satty --filename - \
            --output-filename "$dir/%Y-%m-%d_%H-%M-%S.png" \
            --copy-command 'flatpak-spawn --host wl-copy' 9>&-
        ;;
esac
