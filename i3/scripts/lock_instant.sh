#!/bin/bash

# Instant lock screen script with live blur effect
# Uses the enhanced i3lock (i3lock-color) for immediate locking with blur

# Check which i3lock version we have
if i3lock --help 2>&1 | grep -q "blur"; then
    # We have i3lock-color installed (as i3lock)
    i3lock \
        --blur=5 \
        --clock \
        --indicator \
        --pass-media-keys \
        --pass-screen-keys \
        --pass-volume-keys \
        --nofork
else
    # Fallback to regular i3lock with screenshot blur
    TEMP_SCREENSHOT="/tmp/lockscreen_blur.png"
    
    # Quick screenshot and blur
    maim "$TEMP_SCREENSHOT"
    
    # Use magick instead of deprecated convert
    if command -v magick &> /dev/null; then
        magick "$TEMP_SCREENSHOT" -blur 0x8 "$TEMP_SCREENSHOT"
    else
        convert "$TEMP_SCREENSHOT" -blur 0x8 "$TEMP_SCREENSHOT"
    fi
    
    # Lock with blurred screenshot
    i3lock -i "$TEMP_SCREENSHOT"
    
    # Clean up
    rm -f "$TEMP_SCREENSHOT"
fi
