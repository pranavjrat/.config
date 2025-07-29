#!/bin/bash
# Aggressive Battery Power Management

# Check if we're on battery
if [ "$(cat /sys/class/power_supply/BAT*/status)" = "Discharging" ]; then
    echo "Applying aggressive battery optimizations..."
    
    # CPU frequency scaling - more aggressive
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        [ -w "$cpu" ] && echo powersave > "$cpu"
    done
    
    # Reduce CPU turbo boost
    echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
    
    # More aggressive USB power management
    for device in /sys/bus/usb/devices/*/power/autosuspend_delay_ms; do
        [ -w "$device" ] && echo 500 > "$device"
    done
    
    # Disable wake-on-LAN and other network wake sources
    ethtool -s $(ip route | grep default | awk '{print $5}' | head -1) wol d 2>/dev/null || true
    
    # More aggressive disk power management
    for disk in /dev/sd*; do
        [ -b "$disk" ] && hdparm -B 1 -S 60 "$disk" 2>/dev/null || true
    done
    
    # Reduce screen brightness automatically
    if [ -f /sys/class/backlight/intel_backlight/brightness ]; then
        current=$(cat /sys/class/backlight/intel_backlight/brightness)
        max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
        new=$((max * 30 / 100))  # Set to 30%
        echo $new > /sys/class/backlight/intel_backlight/brightness
    fi
    
    # Disable unnecessary services on battery
    systemctl stop bluetooth 2>/dev/null || true
    
else
    echo "On AC power, applying balanced optimizations..."
    
    # Restore performance settings when plugged in
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        [ -w "$cpu" ] && echo performance > "$cpu"
    done
    echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo
    
    # Restore services
    systemctl start bluetooth 2>/dev/null || true
fi

echo "Power management applied for current power state"
