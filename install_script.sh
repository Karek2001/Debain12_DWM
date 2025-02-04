#!/usr/bin/env bash
#
# install_script.sh
#
# Script to install required packages, configure sxhkd, install Firefox from Mozilla,
# configure windsurf, and finally enable the non-free Debian repository and install
# the NVIDIA driver.

# Exit immediately if a command exits with a non-zero status:
set -e

echo "=== Updating package lists... ==="
sudo apt update -y

echo "=== Installing required packages... ==="
# Replace "i" with "sudo apt install" for all listed packages:
sudo apt install -y \
  make \
  gcc \
  libx11-dev \
  libxft-dev \
  libxinerama-dev \
  git \
  patch \
  sxhkd \
  audacious \
  htop \
  fonts-firacode \
  tar \
  xz-utils \
  xserver-xorg-core

echo "=== Creating sxhkd configuration folder and file... ==="
# Create ~/.config/sxhkd if it doesn't exist:
mkdir -p "${HOME}/.config/sxhkd"

# Create a default .sxhkdrc if it doesn't exist:
if [ ! -f "${HOME}/.config/sxhkd/sxhkdrc" ]; then
cat << 'EOF' > "${HOME}/.config/sxhkd/sxhkdrc"
# Example sxhkd config
# Modify or add your own key bindings here.

# Example:
super + Return
    x-terminal-emulator

super + d
    dmenu_run
EOF
  echo "Created a default sxhkdrc at ~/.config/sxhkd/sxhkdrc"
else
  echo "sxhkdrc already exists. Skipping creation."
fi

echo "=== Installing Firefox from Mozilla's repository... ==="
# 1. Create keyrings directory (if it doesn't exist)
sudo install -d -m 0755 /etc/apt/keyrings

# 2. Download and install the Mozilla GPG key
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- \
  | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

# 3. Verify the key fingerprint
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc \
| awk '/pub/{
    getline
    gsub(/^ +| +$/,"")
    if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3")
      print "\nThe key fingerprint matches ("$0").\n"
    else
      print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"
  }'

# 4. Add the Mozilla apt source
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
  | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

# 5. Pin Mozilla packages with high priority
cat << 'EOF' | sudo tee /etc/apt/preferences.d/mozilla > /dev/null
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
EOF

# 6. Update and install Firefox
sudo apt-get update -y
sudo apt-get install -y firefox

echo "=== Configuring and upgrading windsurf... ==="
# Add Codeium's windsurf repository key
curl -fsSL "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" \
  | sudo gpg --dearmor -o /usr/share/keyrings/windsurf-stable-archive-keyring.gpg

# Add windsurf repository
echo "deb [signed-by=/usr/share/keyrings/windsurf-stable-archive-keyring.gpg arch=amd64] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" \
  | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null

# Update and upgrade windsurf
sudo apt-get update -y
sudo apt-get upgrade -y windsurf

echo "=== Prompt to add non-free repository (Debian bullseye) ==="
echo "You now need to add the following line to your /etc/apt/sources.list (if not already present):"
echo
echo "  deb http://deb.debian.org/debian/ bullseye main contrib non-free"
echo
echo "Opening /etc/apt/sources.list in nano..."
echo "Press Ctrl+O, Enter, Ctrl+X to save and exit nano."
read -rp "Press Enter to continue..."
sudo nano /etc/apt/sources.list

echo "=== Updating again and installing NVIDIA driver... ==="
sudo apt update -y
sudo apt install -y nvidia-driver

echo "=== Done! ==="
echo "All steps completed successfully."
