#!/bin/bash

# Script to install non-free drivers on Debian 12 (Bookworm)
# Customized for GL75 Leopard 10SFK with Intel i7-10750H & NVIDIA RTX 2070 Mobile
# Driver installation only - no configuration changes

set -e  # Exit on error
set -u  # Treat unset variables as errors

# Must run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Try 'sudo $0'"
    exit 1
fi

# Colors for better output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Debian 12 Non-Free Drivers Installation Script ===${NC}"
echo -e "${YELLOW}Installing drivers for GL75 Leopard with Intel + NVIDIA hardware${NC}"
echo

# Update package lists
echo -e "${GREEN}[1/4] Updating package lists...${NC}"
apt update

# Install firmware packages
echo -e "${GREEN}[2/4] Installing essential firmware packages...${NC}"
apt install -y firmware-linux firmware-linux-nonfree

# Install specific drivers for hardware
echo -e "${GREEN}[3/4] Installing hardware-specific drivers...${NC}"

# NVIDIA RTX 2070 Mobile drivers
echo -e "${YELLOW}Installing NVIDIA RTX 2070 Mobile drivers...${NC}"
apt install -y nvidia-driver nvidia-cuda-toolkit

# Intel drivers (for Intel UHD Graphics)
echo -e "${YELLOW}Installing Intel UHD Graphics drivers...${NC}"
apt install -y intel-media-va-driver i965-va-driver

# Wireless drivers (common for MSI laptops)
echo -e "${YELLOW}Installing wireless drivers...${NC}"
apt install -y firmware-iwlwifi firmware-realtek

# Sound drivers
echo -e "${YELLOW}Installing audio drivers...${NC}"
apt install -y firmware-sof-signed alsa-utils

# Final update 
echo -e "${GREEN}[4/4] Final update...${NC}"
apt update

echo
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo -e "${YELLOW}You may need to reboot your system for all drivers to take effect.${NC}"
