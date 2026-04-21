#!/bin/bash
WEATHER=$(curl -sf "https://wttr.in/?format=%c+%t" 2>/dev/null)
if [ -z "$WEATHER" ]; then
    echo "󰼭 N/A"
else
    echo "$WEATHER"
fi
