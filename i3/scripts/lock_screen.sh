#!/bin/bash

# Enhanced lock screen script for betterlockscreen
# This script captures the current screen and applies blur effect

# Check if required tools are installed
if ! command -v betterlockscreen &> /dev/null; then
    notify-send "Error" "betterlockscreen is not installed. Please install it with: yay -S betterlockscreen"
    exit 1
fi

if ! command -v maim &> /dev/null; then
    notify-send "Error" "maim is not installed. Please install it with: sudo pacman -S maim"
    exit 1
fi

# Create temporary directory for screenshots
TEMP_DIR="/tmp/lockscreen_$(date +%s)"
mkdir -p "$TEMP_DIR"

# Capture current screen
SCREENSHOT="$TEMP_DIR/current_screen.png"
maim "$SCREENSHOT"

# Update betterlockscreen with current screen capture
betterlockscreen -u "$SCREENSHOT"

# Execute betterlockscreen with blur effect
betterlockscreen -l blur --off 300

# Clean up temporary files
rm -rf "$TEMP_DIR"
