#!/bin/bash

# Script to download and install Telegram
# This script requires wget

# Create downloads directory
DOWNLOAD_DIR="$HOME/downloads"
mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

echo "Created download directory at: $DOWNLOAD_DIR"

# Check if wget is installed
if ! command -v wget &> /dev/null; then
    echo "Installing wget..."
    sudo apt-get update && sudo apt-get install -y wget
fi

# Check for required commands
for cmd in tar; do
    if ! command -v $cmd &> /dev/null; then
        echo "Installing $cmd..."
        sudo apt-get update && sudo apt-get install -y $cmd
    fi
done

# Download and install Telegram
echo "========== Downloading and Installing Telegram =========="
echo "Downloading Telegram..."
wget -O "telegram_linux.tar.xz" "https://telegram.org/dl/desktop/linux" --show-progress

if [ $? -eq 0 ]; then
    echo "✓ Successfully downloaded Telegram"
    echo "Extracting Telegram..."
    mkdir -p "$HOME/Applications/Telegram"
    tar -xJf telegram_linux.tar.xz -C "$HOME/Applications/Telegram" --strip-components=1
    echo "Creating desktop shortcut..."
    mkdir -p "$HOME/.local/share/applications"
    echo "[Desktop Entry]
Name=Telegram
GenericName=Messaging Client
Comment=Official desktop client for the Telegram messaging service
TryExec=$HOME/Applications/Telegram/Telegram
Exec=$HOME/Applications/Telegram/Telegram -- %u
Icon=$HOME/Applications/Telegram/telegram.svg
Terminal=false
Type=Application
Categories=Network;InstantMessaging;Chat;" > "$HOME/.local/share/applications/telegram.desktop"
    echo "✓ Telegram installed successfully"
    echo "You may need to log out and log back in for the desktop shortcut to appear."
else
    echo "✗ Failed to download Telegram"
    exit 1
fi
