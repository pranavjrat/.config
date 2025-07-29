#!/bin/bash
# Script to reinstall i3-related packages that were removed during Hyprland transition
# Run this if you want to switch back to i3 or need i3 packages for testing

set -e  # Exit on any error

echo "🔧 i3 Package Installation Script"
echo "================================="
echo "This script will install i3 window manager and related packages."
echo ""

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    echo "❌ Error: This script is designed for Arch Linux (pacman not found)"
    exit 1
fi

# Ask for confirmation
read -p "Do you want to install i3 packages? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo "📦 Installing i3 packages..."

# Core i3 packages
echo "Installing i3 window manager and core components..."
sudo pacman -S --needed i3-wm i3blocks i3status

echo "Installing i3 session management..."
sudo pacman -S --needed i3-resurrect

echo "Installing lock screen utilities..."
sudo pacman -S --needed i3lock-color i3lock-color-debug

echo "Installing status bar..."
sudo pacman -S --needed polybar

echo "Installing additional utilities..."
sudo pacman -S --needed xdotool  # For automation and scripting

# Optional packages that work well with i3
echo ""
echo "🔧 Optional i3-related packages:"
echo "1. rofi - Application launcher and window switcher"
echo "2. dunst - Notification daemon"
echo "3. picom - Compositor for transparency and effects"
echo "4. feh - Wallpaper setter"
echo "5. lxappearance - GTK theme configuration"

read -p "Install optional packages? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing optional packages..."
    sudo pacman -S --needed rofi dunst picom feh lxappearance
fi

echo ""
echo "✅ i3 package installation completed!"
echo ""
echo "📋 Next steps:"
echo "1. Log out and select i3 from your display manager"
echo "2. Restore your i3 configuration from backup if available"
echo "3. Configure polybar, rofi, and other components as needed"
echo ""
echo "📁 Configuration directories:"
echo "   - i3: ~/.config/i3/"
echo "   - polybar: ~/.config/polybar/"
echo "   - rofi: ~/.config/rofi/"
echo "   - i3-resurrect: ~/.config/i3-resurrect/"
echo ""
echo "💡 Tip: You can switch between Hyprland and i3 by selecting different sessions"
echo "    at your display manager login screen."
