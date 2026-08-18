#!/bin/bash
CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/wl-gammactl-gamma"
DEFAULT_GAMMA=1.0
STEP=0.05
MIN_GAMMA=0.5
MAX_GAMMA=1.5

WLGAMMACTL="wl-gammactl"

get_gamma() {
    [ -f "$CACHE" ] && cat "$CACHE" || echo "$DEFAULT_GAMMA"
}

set_gamma() {
    printf '%s' "$1" > "$CACHE"
}

case "$1" in
    toggle)
        if [ -f "$CACHE" ]; then
            rm "$CACHE"
            "$WLGAMMACTL" -c 1 -b 1 -g 1
        else
            "$WLGAMMACTL" -c 1 -b 1 -g "$(get_gamma)"
        fi
        ;;
    warmer)
        gamma=$(echo "$(get_gamma) - $STEP" | bc)
        $(echo "$gamma < $MIN_GAMMA" | bc -l) && gamma=$MIN_GAMMA
        set_gamma "$gamma"
        "$WLGAMMACTL" -c 1 -b 1 -g "$gamma"
        ;;
    cooler)
        gamma=$(echo "$(get_gamma) + $STEP" | bc)
        $(echo "$gamma > $MAX_GAMMA" | bc -l) && gamma=$MAX_GAMMA
        set_gamma "$gamma"
        "$WLGAMMACTL" -c 1 -b 1 -g "$gamma"
        ;;
    gamma)
        get_gamma
        ;;
    *)
        echo "usage: nightlight.sh {toggle|warmer|cooler|gamma}"
        exit 1
        ;;
esac
