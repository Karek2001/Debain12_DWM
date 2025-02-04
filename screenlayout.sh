#!/bin/bash
sleep 2  # Optional: wait 2 seconds for the X session to fully initialize

# Configure external monitor
xrandr --output HDMI-1-0 --mode 3440x1440 --rate 100 --pos 0x0

# Configure primary internal display
xrandr --output eDP-1 --mode 1920x1080 --rate 144 --pos 760x1440 --primary
