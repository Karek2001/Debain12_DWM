#!/bin/bash
# Function to check if HDMI is physically connected
check_hdmi() {
    xrandr | grep "HDMI-1-1 connected" > /dev/null
}
# Function to handle display setup
setup_displays() {
    # Wait for X server
    sleep 2
    if check_hdmi; then
        # Reset both outputs first
        xrandr --output HDMI-1-1 --off
        xrandr --output eDP-1 --off
        sleep 1
        # Setup primary laptop display
        xrandr --output eDP-1 --mode 1920x1080 --rate 144 --pos 0x0 --primary
        sleep 1
        # Setup external monitor to the right
        xrandr --output HDMI-1-1 --mode 1920x1080 --rate 144 --right-of eDP-1
    else
        # Fallback to laptop display only
        xrandr --output eDP-1 --mode 1920x1080 --rate 144 --primary
        xrandr --output HDMI-1-1 --off
    fi
}
# Main execution
setup_displays
