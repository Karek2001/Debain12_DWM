#!/bin/bash

# Script to download and install Postman
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

# Download and install Postman
echo "========== Downloading and Installing Postman =========="
echo "Downloading Postman..."
wget -O "postman_linux_64.tar.gz" "https://dl.pstmn.io/download/latest/linux_64" --show-progress

if [ $? -eq 0 ]; then
    echo "✓ Successfully downloaded Postman"
    echo "Extracting Postman..."
    mkdir -p "$HOME/Applications/Postman"
    tar -xzf postman_linux_64.tar.gz -C "$HOME/Applications/Postman" --strip-components=1
    echo "Creating desktop shortcut..."
    mkdir -p "$HOME/.local/share/applications"
    echo "[Desktop Entry]
Name=Postman
GenericName=API Client
X-GNOME-FullName=Postman API Client
Comment=Make and manage API requests
Keywords=api;
Exec=$HOME/Applications/Postman/Postman
Terminal=false
Type=Application
Icon=$HOME/Applications/Postman/app/resources/app/assets/icon.png
Categories=Development;Utility;" > "$HOME/.local/share/applications/postman.desktop"
    echo "✓ Postman installed successfully"
    echo "You may need to log out and log back in for the desktop shortcut to appear."
else
    echo "✗ Failed to download Postman"
    exit 1
fi
