#!/bin/sh
# DBus and core services
eval "$(dbus-launch --sh-syntax --exit-with-session)"
/usr/lib/at-spi2-core/at-spi-bus-launcher --launch-immediately &

# Environment variables
export XDG_CURRENT_DESKTOP=DWM
export XDG_SESSION_TYPE=x11
export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_THEME=Adwaita:dark
# XDG portal services
/usr/libexec/xdg-desktop-portal &
/usr/libexec/xdg-desktop-portal-gtk &

# Keyboard setup

~/ScriptsForOS/keyboard_65%_Settings/keyboard_setup.sh

# Screen setup with new handler
~/ScriptsForOS/ScreenLayout.sh
# Other services
(sleep 1 && firefox) &
slstatus &
blueman-applet &

picom --config ~/.config/picom/picom.conf &
feh --bg-fill /mnt/disk2/debainWallpaper.jpg &

# Start window manager
exec dwm
