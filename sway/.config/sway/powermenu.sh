#!/usr/bin/env bash

MENU=" Lock\n Sleep\n󰍃 Logout\n Restart\n⏻ Shutdown\n BIOS"

confirm() {
  choice=$(printf "No\nYes" | wofi --dmenu --prompt "Confirm?")
  [ "$choice" = "Yes" ]
}

run_action() {
  case "$1" in
    " Lock")
      swaylock
      ;;

    " Sleep")
      confirm && systemctl suspend
      ;;

    "󰍃 Logout")
      confirm && swaymsg exit
      ;;

    " Restart")
      confirm && systemctl reboot
      ;;

    "⏻ Shutdown")
      confirm && systemctl poweroff
      ;;

    " BIOS")
      confirm && systemctl reboot --firmware-setup
      ;;

    *)
      exit 0
      ;;
  esac
}

choice=$(printf "$MENU" | wofi --dmenu --prompt "Power Menu" --width 320 --height 260)

run_action "$choice"
