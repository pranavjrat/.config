#!/bin/bash

# Simple WiFi network menu for JARVIS Polybar
# Shows network options in a rofi menu

# Set PATH to ensure commands are found
export PATH="/usr/bin:/bin:/usr/local/bin:$PATH"

# Log for debugging
echo "$(date): WiFi script called" >> /tmp/polybar-wifi.log

# Check if rofi is available
if ! command -v rofi &> /dev/null; then
    notify-send "Error" "Rofi not found" -i dialog-error
    echo "$(date): Rofi not found" >> /tmp/polybar-wifi.log
    exit 1
fi

# Check if nmcli is available
if ! command -v nmcli &> /dev/null; then
    notify-send "Error" "NetworkManager not found" -i dialog-error
    echo "$(date): nmcli not found" >> /tmp/polybar-wifi.log
    exit 1
fi

echo "$(date): Starting rofi menu" >> /tmp/polybar-wifi.log

# Main menu options
choice=$(echo -e "📡 Available Networks\n🔄 Refresh WiFi\n⚙️ Network Settings\n📋 Saved Connections" | rofi -dmenu -p "📡 WiFi Menu" -theme-str 'window {background-color: #000814;} listview {background-color: #001122;} element selected {background-color: #00d4ff; text-color: #000814;}')

case "$choice" in
    "📡 Available Networks")
        # Show available networks
        nmcli device wifi rescan 2>/dev/null
        sleep 1
        networks=$(nmcli -f SSID,SIGNAL,SECURITY device wifi list | tail -n +2 | head -15)
        if [ -n "$networks" ]; then
            selected=$(echo "$networks" | rofi -dmenu -p "📡 Select Network" -theme-str 'window {background-color: #000814;} listview {background-color: #001122;} element selected {background-color: #00d4ff; text-color: #000814;}')
            if [ -n "$selected" ]; then
                ssid=$(echo "$selected" | awk '{print $1}')
                security=$(echo "$selected" | awk '{print $3}')
                
                if [[ "$security" == "--" ]] || [[ -z "$security" ]]; then
                    nmcli device wifi connect "$ssid" && notify-send "📡 WiFi" "Connected to $ssid" -i network-wireless
                else
                    password=$(rofi -dmenu -p "🔐 Password for $ssid" -password -theme-str 'window {background-color: #000814;}')
                    if [ -n "$password" ]; then
                        nmcli device wifi connect "$ssid" password "$password" && notify-send "📡 WiFi" "Connected to $ssid" -i network-wireless || notify-send "📡 WiFi" "Failed to connect" -i network-error
                    fi
                fi
            fi
        else
            notify-send "📡 WiFi" "No networks found" -i network-offline
        fi
        ;;
    "🔄 Refresh WiFi")
        nmcli device wifi rescan
        notify-send "📡 WiFi" "Refreshing networks..." -i network-wireless
        ;;
    "⚙️ Network Settings")
        if command -v nm-connection-editor &> /dev/null; then
            nm-connection-editor &
        elif command -v gnome-control-center &> /dev/null; then
            gnome-control-center wifi &
        else
            notify-send "📡 WiFi" "No network settings app found" -i dialog-error
        fi
        ;;
    "📋 Saved Connections")
        connections=$(nmcli connection show | grep wifi | awk '{print $1}')
        if [ -n "$connections" ]; then
            selected=$(echo "$connections" | rofi -dmenu -p "📡 Saved Networks" -theme-str 'window {background-color: #000814;}')
            if [ -n "$selected" ]; then
                nmcli connection up "$selected" && notify-send "📡 WiFi" "Connected to $selected" -i network-wireless
            fi
        else
            notify-send "📡 WiFi" "No saved connections" -i network-offline
        fi
        ;;
esac
