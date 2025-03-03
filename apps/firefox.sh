#!/bin/bash

# Install Firefox .deb package for Debian-based distributions
# This script automates the installation of Firefox through the official Mozilla APT repository

echo "Installing Firefox from Mozilla's APT repository..."

# Create directory to store APT repository keys if it doesn't exist
echo "Creating directory for APT repository keys..."
sudo install -d -m 0755 /etc/apt/keyrings

# Import the Mozilla APT repository signing key
echo "Importing Mozilla APT repository signing key..."
if ! command -v wget &> /dev/null; then
    echo "wget not found. Installing wget..."
    sudo apt-get install -y wget
fi
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

# Verify the key fingerprint
echo "Verifying key fingerprint..."
FINGERPRINT=$(gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); print $0}')
if [ "$FINGERPRINT" = "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3" ]; then
    echo "The key fingerprint matches ($FINGERPRINT)."
else
    echo "Verification failed: the fingerprint ($FINGERPRINT) does not match the expected one."
    echo "Expected: 35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3"
    exit 1
fi

# Add the Mozilla APT repository to sources list
echo "Adding Mozilla APT repository to sources list..."
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

# Configure APT to prioritize packages from the Mozilla repository
echo "Configuring APT preferences for Mozilla packages..."
echo 'Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000' | sudo tee /etc/apt/preferences.d/mozilla

# Update package list and install Firefox
echo "Updating package list and installing Firefox..."
sudo apt-get update && sudo apt-get install -y firefox

echo "Firefox installation complete!"
