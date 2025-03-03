#!/bin/bash

# Install Windsurf script
# This script automates the installation of Windsurf

echo "Installing Windsurf..."

# Step 1: Add the Windsurf repository and key
echo "Adding Windsurf repository and key..."
curl -fsSL "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/windsurf-stable-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/windsurf-stable-archive-keyring.gpg arch=amd64] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null

# Step 2: Update package index
echo "Updating package lists..."
sudo apt-get update

# Step 3: Install/upgrade Windsurf
echo "Installing/upgrading Windsurf..."
sudo apt-get upgrade windsurf

echo "Windsurf installation complete!"
