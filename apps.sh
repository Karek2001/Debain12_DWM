#!/bin/bash

# Script to install essential packages
# Generated for DWM setup

echo "Installing essential packages..."

# Update system first
sudo apt update
sudo apt upgrade -y

# Install system essentials
echo "Installing system essentials..."
sudo apt install -y \
apt-transport-https \
ca-certificates \
software-properties-common \
gnupg \
locales \
man-db \
sudo \
systemd-timesyncd \
tasksel

# Install X11 server and related packages
echo "Installing X11 server and dependencies..."
sudo apt install -y \
xorg \
xserver-xorg \
xserver-xorg-core \
libx11-dev \
libxft-dev \
libxinerama-dev \
libxrandr-dev \
xinit \
x11-xserver-utils

# Install build tools for DWM
echo "Installing build dependencies for DWM..."
sudo apt install -y \
build-essential \
gcc \
make \
pkg-config \
autoconf

# Install essential packages
echo "Installing other essential packages..."
sudo apt install -y \
7zip \
amd64-microcode \
acpi \
alsa-utils \
arandr \
bat \
blueman \
bluez \
bluez-tools \
brightnessctl \
bzip2 \
code \
curl \
dbus-x11 \
dialog \
dunst \
fastfetch \
feh \
ffmpeg \
firefox-esr \
fonts-liberation2 \
fonts-noto \
fonts-noto-cjk \
fonts-noto-color-emoji \
fzf \
git \
gnome-keyring \
gzip \
htop \
imagemagick \
intel-microcode \
iptables \
mc \
neomutt \
network-manager \
network-manager-gnome \
nnn \
nodejs \
notification-daemon \
ntp \
numlockx \
openssh-client \
p7zip \
pass \
pavucontrol \
picom \
pipewire \
pipewire-pulse \
policykit-1-gnome \
pulseaudio-utils \
qrencode \
ranger \
redisinsight \
ripgrep \
scrot \
ssh \
st \
suckless-tools \
sxhkd \
tlp \
ufw \
unzip \
vim \
vifm \
vlc \
volumeicon-alsa \
w3m \
wget \
wireless-tools \
wpasupplicant \
xbacklight \
xclip \
xdg-user-dirs \
xdg-utils \
xdotool \
xinput \
xss-lock \
zathura \
zip \
zoxide \
remmina \ 
remmina-plugin-rdp \
remmina-plugin-vnc \
echo "Installation complete!"
