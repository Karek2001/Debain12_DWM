#!/bin/bash

# Force sending wake signal to HDMI
xset dpms force on

# Small delay
sleep 1

# Send specific DPMS commands to both displays
xset -display :0 dpms force on
xrandr --output HDMI-1-0 --auto
xrandr --output eDP-1 --auto

# Rerun the display configuration
~/monitor-handler.sh

# Optional: Send a dummy keystroke to wake the system
# (only if needed - comment out if causing issues)
xdotool key Shift_L
