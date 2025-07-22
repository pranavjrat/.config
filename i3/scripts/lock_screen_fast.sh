#!/bin/bash

# Fast lock screen script for betterlockscreen
# This version captures and locks in one go for better performance

# Check if required tools are installed
if ! command -v betterlockscreen &> /dev/null; then
    notify-send "Error" "betterlockscreen is not installed"
    exit 1
fi

if ! command -v maim &> /dev/null; then
    notify-send "Error" "maim is not installed"
    exit 1
fi

# Capture current screen and lock immediately
TEMP_SCREENSHOT="/tmp/lockscreen_current.png"
maim "$TEMP_SCREENSHOT" && betterlockscreen -u "$TEMP_SCREENSHOT" && betterlockscreen -l blur --off 300

# Clean up
rm -f "$TEMP_SCREENSHOT"
