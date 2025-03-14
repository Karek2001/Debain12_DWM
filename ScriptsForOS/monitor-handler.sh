#!/bin/bash

# Configure displays with eDP-1 (laptop screen) as primary and HDMI-1-1 to the right
xrandr --output eDP-1 --mode 1920x1080 --rate 144 --primary
xrandr --output HDMI-1-1 --mode 1920x1080 --rate 144 --right-of eDP-1

echo "Monitors configured successfully!"
