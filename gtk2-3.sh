#!/bin/bash

# Script to set up dark themes for GTK 2.0 and GTK 3.0
# For Debian 12 with DWM

echo "Setting up dark themes for GTK 2.0 and GTK 3.0..."

# Create required directories
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-2.0

# Install Arc-Dark theme if not already installed
if ! dpkg -l | grep -q arc-theme; then
    echo "Installing Arc-Dark theme..."
    sudo apt update
    sudo apt install -y arc-theme
fi

# Install additional icon themes
echo "Installing icon themes..."
sudo apt install -y adwaita-icon-theme papirus-icon-theme

# Create GTK 3.0 settings.ini with dark theme
echo "Creating GTK 3.0 settings.ini..."
cat > ~/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name=Arc-Dark
gtk-icon-theme-name=Papirus-Dark
gtk-font-name=Sans 10
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintslight
gtk-xft-rgba=rgb
gtk-application-prefer-dark-theme=1
EOF

# Create GTK 2.0 gtkrc-2.0 with dark theme
echo "Creating GTK 2.0 settings (gtkrc-2.0)..."
cat > ~/.gtkrc-2.0 << EOF
gtk-theme-name="Arc-Dark"
gtk-icon-theme-name="Papirus-Dark"
gtk-font-name="Sans 10"
gtk-cursor-theme-name="Adwaita"
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle="hintslight"
gtk-xft-rgba="rgb"
EOF

# Create GTK file chooser settings
echo "Creating GTK file chooser settings..."
cat > ~/.config/gtk-3.0/gtkfilechooser.ini << EOF
[Filechooser Settings]
LocationMode=path-bar
ShowHidden=false
ShowSizeColumn=true
GeometryX=-1
GeometryY=-1
GeometryWidth=-1
GeometryHeight=-1
SortColumn=name
SortOrder=ascending
StartupMode=recent
ClockFormat=24h
EnableSnapshotFolders=True
ShowFullPathnames=False
LastFolderUri=file:///home/$USER
EOF

# Set theme for Qt applications to follow GTK
echo "Setting up Qt applications to use GTK theme..."
sudo apt install -y qt5ct qt5-style-plugins
echo "QT_QPA_PLATFORMTHEME=gtk2" >> ~/.profile

echo "Dark theme setup complete! Log out and log back in for all changes to take effect."
