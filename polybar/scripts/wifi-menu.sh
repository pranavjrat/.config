#!/bin/bash

# JARVIS WiFi Menu Script
# Provides WiFi connection options when clicked

# Check if NetworkManager is available
if command -v nmcli &> /dev/null; then
    # Get available networks
    networks=$(nmcli -t -f SSID device wifi list | head -10)
    
    if [ -n "$networks" ]; then
        # Show network selection with rofi
        selected=$(echo "$networks" | rofi -dmenu -p "🌐 JARVIS Network Selection" -theme-str 'window {background-color: #000814;} listview {background-color: #001122;} element selected {background-color: #00d4ff; text-color: #000814;}')
        
        if [ -n "$selected" ]; then
            # Connect to selected network
            nmcli device wifi connect "$selected" && notify-send "JARVIS" "Connected to $selected" -i network-wireless || notify-send "JARVIS" "Failed to connect to $selected" -i network-error
        fi
    else
        notify-send "JARVIS" "No networks found. Scanning..." -i network-wireless
        nmcli device wifi rescan
    fi
else
    # Fallback to basic network settings
    if command -v nm-connection-editor &> /dev/null; then
        nm-connection-editor
    elif command -v gnome-control-center &> /dev/null; then
        gnome-control-center wifi
    else
        notify-send "JARVIS" "Network manager not found" -i network-error
    fi
fi
