#!/bin/bash

# JARVIS Media Info Script
# Shows current media information

# Check for playerctl first
if command -v playerctl &> /dev/null; then
    status=$(playerctl status 2>/dev/null)
    if [ "$status" = "Playing" ]; then
        artist=$(playerctl metadata artist 2>/dev/null)
        title=$(playerctl metadata title 2>/dev/null)
        if [ -n "$artist" ] && [ -n "$title" ]; then
            echo "▶ ${title:0:15}"
        else
            echo "▶"
        fi
    elif [ "$status" = "Paused" ]; then
        echo "⏸"
    else
        echo "⏹"
    fi
# Fallback to mpc
elif command -v mpc &> /dev/null; then
    current=$(mpc current 2>/dev/null)
    if [ -n "$current" ]; then
        status=$(mpc status | grep '\[playing\]')
        if [ -n "$status" ]; then
            echo "🎵 ▶ ${current:0:25}"
        else
            echo "🎵 ⏸ ${current:0:25}"
        fi
    else
        echo "🎵 📴 No Media"
    fi
else
    echo "🎵 📴 No Player"
fi
