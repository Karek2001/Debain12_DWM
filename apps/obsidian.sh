#!/bin/bash

# Script to download and install Obsidian
# This script requires wget and sudo privileges

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
for cmd in dpkg; do
    if ! command -v $cmd &> /dev/null; then
        echo "Installing $cmd..."
        sudo apt-get update && sudo apt-get install -y $cmd
    fi
done

# Download and install Obsidian
echo "========== Downloading and Installing Obsidian =========="
echo "Downloading Obsidian..."
wget -O "obsidian_1.8.7_amd64.deb" "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.8.7/obsidian_1.8.7_amd64.deb" --show-progress

if [ $? -eq 0 ]; then
    echo "✓ Successfully downloaded Obsidian"
    echo "Installing Obsidian..."
    sudo dpkg -i obsidian_1.8.7_amd64.deb
    
    if [ $? -ne 0 ]; then
        echo "Fixing dependencies..."
        sudo apt-get install -f -y
        # Try installing again
        sudo dpkg -i obsidian_1.8.7_amd64.deb
    fi
    
    if [ $? -eq 0 ]; then
        echo "✓ Obsidian installed successfully"
    else
        echo "⚠️ Failed to install Obsidian"
        exit 1
    fi
else
    echo "✗ Failed to download Obsidian"
    exit 1
fi
