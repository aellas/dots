#!/usr/bin/env sh

options="Shutdown\nReboot\nSuspend\nLock\nLogout"

chosen=$(echo -e "$options" | rofi -dmenu -theme-str 'window { width: 10%; }' -no-fixed-num-lines -i -p "Powermenu")

case "$chosen" in
"Shutdown")
	systemctl poweroff
	;;
"Reboot")
	systemctl reboot
	;;
"Suspend")
	systemctl suspend
	;;
"Lock")
	xsecurelock
	;;
"Logout")
	bspc quit && killall bspwm && exit 0
	;;
esac
