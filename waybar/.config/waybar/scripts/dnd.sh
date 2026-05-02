#!/bin/bash
if makoctl mode | grep -q do-not-disturb; then
    echo '{"text":"󰂛","class":"do-not-disturb","tooltip":"DND on"}'
else
    echo '{"text":"󰂚","class":"","tooltip":"DND off"}'
fi
