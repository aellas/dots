#!/usr/bin/env sh

chosen=$(printf '%s\n' "Logout" "Shutdown" "Reboot" "Lock" "[Cancel]" |
	rofi -dmenu -i -p "Power Menu" -line-padding 4 -hide-scrollbar -theme-str 'window { width: 11%; }' -no-fixed-num-lines)

case "$chosen" in
Logout) bspc quit ;;
Shutdown) systemctl poweroff ;;
Reboot) systemctl reboot ;;
Lock) xsecurelock ;;
*) exit 0 ;;
esac
