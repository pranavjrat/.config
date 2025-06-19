#!/bin/bash

# Script to detect window class names for i3-resurrect configuration
# This helps identify the correct class names for applications

echo "=== Window Class Detector for i3-resurrect ==="
echo "This script will help you identify the correct window class names"
echo "for applications that aren't being saved/restored properly."
echo ""

# Function to get all window classes
get_all_classes() {
    echo "All currently open window classes:"
    echo "=================================="
    i3-msg -t get_tree | jq -r '
        .. | 
        select(.type?) | 
        select(.type=="con") | 
        select(.window_properties?) | 
        .window_properties.class
    ' | sort | uniq -c | sort -nr
    echo ""
}

# Function to get detailed window info
get_detailed_info() {
    echo "Detailed window information:"
    echo "============================"
    i3-msg -t get_tree | jq -r '
        .. | 
        select(.type?) | 
        select(.type=="con") | 
        select(.window_properties?) | 
        "Class: \(.window_properties.class // "unknown") | Instance: \(.window_properties.instance // "unknown") | Title: \(.name // "unknown")"
    ' | sort
    echo ""
}

# Function to monitor window classes in real-time
monitor_windows() {
    echo "Real-time window monitoring (press Ctrl+C to stop):"
    echo "=================================================="
    echo "Open the applications you want to configure and watch for their class names..."
    echo ""
    
    while true; do
        current_classes=$(i3-msg -t get_tree | jq -r '.. | select(.type?) | select(.type=="con") | select(.window_properties?) | .window_properties.class' | sort | uniq)
        clear
        echo "Current window classes ($(date)):"
        echo "=================================="
        echo "$current_classes"
        echo ""
        echo "Press Ctrl+C to stop monitoring..."
        sleep 2
    done
}

# Function to check specific applications
check_specific_apps() {
    echo "Checking for specific problematic applications:"
    echo "=============================================="
    
    apps=("firefox" "Firefox" "obsidian" "Obsidian" "vlc" "VLC" "vmware" "VMware" "easyeffects" "EasyEffects")
    
    for app in "${apps[@]}"; do
        found=$(i3-msg -t get_tree | jq -r ".. | select(.type?) | select(.type==\"con\") | select(.window_properties?) | select(.window_properties.class | test(\"$app\"; \"i\")) | .window_properties.class" | head -1)
        if [ -n "$found" ]; then
            echo "✓ Found: $app -> $found"
        else
            echo "✗ Not found: $app"
        fi
    done
    echo ""
}

# Function to generate config snippet
generate_config() {
    echo "Generated config snippet based on current windows:"
    echo "================================================="
    echo "{"
    echo '  "window_command_mappings": ['
    
    i3-msg -t get_tree | jq -r '.. | select(.type?) | select(.type=="con") | select(.window_properties?) | .window_properties.class' | sort | uniq | while read class; do
        case "$class" in
            *firefox*|*Firefox*)
                echo "    { \"class\": \"$class\", \"command\": \"firefox --new-window\" },"
                ;;
            *terminal*|*Terminal*)
                echo "    { \"class\": \"$class\", \"command\": \"gnome-terminal\" },"
                ;;
            *kitty*|*Kitty*)
                echo "    { \"class\": \"$class\", \"command\": \"kitty\" },"
                ;;
            *alacritty*|*Alacritty*)
                echo "    { \"class\": \"$class\", \"command\": \"alacritty\" },"
                ;;
            *obsidian*|*Obsidian*)
                echo "    { \"class\": \"$class\", \"command\": \"obsidian\" },"
                ;;
            *vlc*|*VLC*)
                echo "    { \"class\": \"$class\", \"command\": \"vlc\" },"
                ;;
            *vmware*|*VMware*)
                echo "    { \"class\": \"$class\", \"command\": \"vmware-workstation\" },"
                ;;
            *easyeffects*|*EasyEffects*)
                echo "    { \"class\": \"$class\", \"command\": \"easyeffects\" },"
                ;;
        esac
    done
    echo "  ]"
    echo "}"
    echo ""
}

# Main menu
case "$1" in
    "monitor")
        monitor_windows
        ;;
    "detailed")
        get_detailed_info
        ;;
    "generate")
        generate_config
        ;;
    "check")
        check_specific_apps
        ;;
    *)
        echo "Usage: $0 [monitor|detailed|generate|check]"
        echo ""
        echo "Options:"
        echo "  monitor   - Real-time monitoring of window classes"
        echo "  detailed  - Show detailed window information"
        echo "  generate  - Generate config snippet for current windows"
        echo "  check     - Check for specific problematic applications"
        echo "  (no args) - Show all current window classes"
        echo ""
        get_all_classes
        check_specific_apps
        ;;
esac
