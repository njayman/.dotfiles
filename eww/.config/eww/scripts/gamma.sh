#!/bin/sh
[ -f "${XDG_CACHE_HOME:-$HOME/.cache}/wl-gammactl-gamma" ] && echo 1 || echo 0
