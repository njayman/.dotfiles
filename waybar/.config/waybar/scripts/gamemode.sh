#!/bin/bash
if systemctl --user is-active gamemoded | grep -q active; then
    echo '{"text":"󰖺","class":"active","tooltip":"Gamemode on"}'
else
    echo '{"text":"󰖻","class":"","tooltip":"Gamemode off"}'
fi
