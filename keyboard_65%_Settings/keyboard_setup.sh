#!/bin/sh
# Clear any existing Caps Lock modifier
xmodmap -e "clear lock"
# Load your custom keyboard layouts
setxkbmap -layout us,ara -variant custom_caps,custom_caps -option grp:alt_shift_toggle
