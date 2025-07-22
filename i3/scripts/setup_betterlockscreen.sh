#!/bin/bash

# Betterlockscreen setup script
echo "Setting up betterlockscreen..."

# Check if betterlockscreen is installed
if ! command -v betterlockscreen &> /dev/null; then
    echo "Installing betterlockscreen..."
    yay -S betterlockscreen --noconfirm
fi

# Find a wallpaper to use
WALLPAPER=""
if [ -f ~/Pictures/wallpaper.jpg ]; then
    WALLPAPER=~/Pictures/wallpaper.jpg
elif [ -f ~/Pictures/wallpaper.png ]; then
    WALLPAPER=~/Pictures/wallpaper.png
elif [ -f ~/Pictures/*.jpg ]; then
    WALLPAPER=$(find ~/Pictures -name "*.jpg" -type f | head -1)
elif [ -f ~/Pictures/*.png ]; then
    WALLPAPER=$(find ~/Pictures -name "*.png" -type f | head -1)
else
    # Download a default wallpaper if none exists
    mkdir -p ~/Pictures
    wget -O ~/Pictures/default_wallpaper.jpg "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"
    WALLPAPER=~/Pictures/default_wallpaper.jpg
fi

# Setup betterlockscreen with the wallpaper
if [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ]; then
    echo "Setting up betterlockscreen with wallpaper: $WALLPAPER"
    betterlockscreen -u "$WALLPAPER"
    echo "Betterlockscreen setup complete!"
else
    echo "No wallpaper found. Please add a wallpaper to ~/Pictures/ and run:"
    echo "betterlockscreen -u /path/to/your/wallpaper.jpg"
fi

echo "You can test the lock screen with: betterlockscreen -l blur"
