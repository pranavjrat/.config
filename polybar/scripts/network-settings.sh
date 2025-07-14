#!/bin/bash

# Network Settings Script for JARVIS
# Provides WiFi connection options and network management

# Function to show available networks
show_networks() {
    # Get available networks with signal strength
    networks=$(nmcli -f SSID,SIGNAL,SECURITY device wifi list | grep -v "^--" | grep -v "SSID" | sort -k2 -nr | head -15)
    
    if [ -n "$networks" ]; then
        # Show network selection with rofi
        selected=$(echo "$networks" | rofi -dmenu -p "📡 Available Networks" -theme-str 'window {background-color: #000814;} listview {background-color: #001122;} element selected {background-color: #00d4ff; text-color: #000814;}' -i)
        
        if [ -n "$selected" ]; then
            # Extract SSID (first column)
            ssid=$(echo "$selected" | awk '{print $1}')
            
            # Check if network requires password
            security=$(echo "$selected" | awk '{print $3}')
            
            if [[ "$security" == "--" ]] || [[ "$security" == "" ]]; then
                # Open network
                nmcli device wifi connect "$ssid" && notify-send "📡 Network" "Connected to $ssid" -i network-wireless
            else
                # Secured network - prompt for password
                password=$(rofi -dmenu -p "🔐 Password for $ssid" -password -theme-str 'window {background-color: #000814;}')
                if [ -n "$password" ]; then
                    nmcli device wifi connect "$ssid" password "$password" && notify-send "📡 Network" "Connected to $ssid" -i network-wireless || notify-send "📡 Network" "Failed to connect to $ssid" -i network-error
                fi
            fi
        fi
    else
        notify-send "📡 Network" "No networks found. Scanning..." -i network-wireless
        nmcli device wifi rescan
    fi
}

# Function to show network management options
show_menu() {
    choice=$(echo -e "📡 Available Networks\n🔄 Refresh/Rescan\n⚙️ Network Settings\n📋 Saved Connections\n🔧 Connection Info" | rofi -dmenu -p "📡 Network Menu" -theme-str 'window {background-color: #000814;} listview {background-color: #001122;} element selected {background-color: #00d4ff; text-color: #000814;}')
    
    case "$choice" in
        "📡 Available Networks")
            show_networks
            ;;
        "🔄 Refresh/Rescan")
            nmcli device wifi rescan
            notify-send "📡 Network" "Rescanning for networks..." -i network-wireless
            sleep 2
            show_networks
            ;;
        "⚙️ Network Settings")
            if command -v nm-connection-editor &> /dev/null; then
                nm-connection-editor
            elif command -v gnome-control-center &> /dev/null; then
                gnome-control-center wifi
            else
                notify-send "📡 Network" "No network settings app found" -i network-error
            fi
            ;;
        "📋 Saved Connections")
            connections=$(nmcli connection show | grep wifi | awk '{print $1}')
            if [ -n "$connections" ]; then
                selected=$(echo "$connections" | rofi -dmenu -p "📋 Saved Connections" -theme-str 'window {background-color: #000814;}')
                if [ -n "$selected" ]; then
                    nmcli connection up "$selected" && notify-send "📡 Network" "Connected to $selected" -i network-wireless
                fi
            else
                notify-send "📡 Network" "No saved connections found" -i network-wireless
            fi
            ;;
        "🔧 Connection Info")
            current=$(nmcli -t -f NAME connection show --active | head -1)
            if [ -n "$current" ]; then
                info=$(nmcli connection show "$current" | grep -E "(IP4|GENERAL)" | head -10)
                notify-send "📡 Current Connection: $current" "$info" -i network-wireless
            else
                notify-send "📡 Network" "No active connection" -i network-error
            fi
            ;;
    esac
}

# Main execution
if [ "$1" = "networks" ]; then
    show_networks
else
    show_menu
fi
