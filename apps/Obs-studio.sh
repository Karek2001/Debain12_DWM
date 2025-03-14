#!/bin/bash
set -e

# This script installs a minimal X environment, DWM, and OBS Studio on Debian 12.
# It also installs some extra packages (e.g. PulseAudio and ffmpeg) to ensure OBS works properly.

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: Please run this script as root (or with sudo)."
    exit 1
fi

echo "Updating package lists..."
apt update

echo "Installing minimal X environment (Xorg and xinit)..."
apt install -y xorg xinit

echo "Installing DWM (if not already installed)..."
apt install -y dwm

echo "Installing audio server (PulseAudio) and control tool..."
apt install -y pulseaudio pavucontrol

echo "Installing additional dependencies (ffmpeg and Mesa GL libraries)..."
apt install -y ffmpeg libgl1-mesa-glx

echo "Installing OBS Studio..."
apt install -y obs-studio

echo "Installation complete!"
echo "You can start OBS Studio by running 'obs' from your terminal (after starting X with 'startx' or via your DWM session)."
