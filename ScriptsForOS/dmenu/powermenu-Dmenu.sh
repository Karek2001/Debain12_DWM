#!/bin/bash
options="Sleep\nShutdown\nReboot\nLogout"
chosen=$(echo -e "$options" | dmenu -i -p "Power Menu:")
case "$chosen" in
    Sleep)
	sudo pm-suspend
        ;;
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Logout)
        killall dwm
        ;;
esac
