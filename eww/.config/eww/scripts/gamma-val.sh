#!/bin/sh
cat "${XDG_CACHE_HOME:-$HOME/.cache}/wl-gammactl-gamma" 2>/dev/null || echo "1.0"
