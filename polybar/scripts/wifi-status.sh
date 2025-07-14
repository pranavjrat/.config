#!/bin/bash

# WiFi Status Script for JARVIS Polybar
# Shows current WiFi connection status

# Get WiFi interface
interface=$(nmcli device | grep wifi | grep -v p2p | head -1 | awk '{print $1}')

if [ -z "$interface" ]; then
    echo "❌ NO WIFI"
    exit 0
fi

# Get connection status and name
status=$(nmcli device status | grep "^$interface" | awk '{print $3}')

if [ "$status" = "connected" ]; then
    # Get the connection name from active connections
    connection_name=$(nmcli connection show --active | grep wifi | head -1 | awk '{for(i=1;i<=NF-3;i++) printf "%s ", $i; print ""}' | sed 's/ *$//')
    
    if [ -n "$connection_name" ]; then
        echo "📡 $connection_name"
    else
        echo "📡 Connected"
    fi
elif [ "$status" = "disconnected" ]; then
    echo "📡 Disconnected"
else
    echo "📡 Offline"
fi
