#!/bin/bash
# Suspend preparation and wake optimization

case $1 in
    pre)
        echo "Preparing for suspend..."
        
        # Sync filesystem before suspend
        sync
        
        # Stop services that might prevent proper suspend
        systemctl stop NetworkManager 2>/dev/null || true
        
        # Disable problematic wake sources
        echo disabled > /proc/acpi/wakeup 2>/dev/null || true
        echo XHCI > /proc/acpi/wakeup 2>/dev/null || true
        echo RP06 > /proc/acpi/wakeup 2>/dev/null || true
        echo TXHC > /proc/acpi/wakeup 2>/dev/null || true
        
        # Force deep sleep
        echo deep > /sys/power/mem_sleep 2>/dev/null || true
        ;;
        
    post)
        echo "Waking from suspend..."
        
        # Restart services
        systemctl start NetworkManager 2>/dev/null || true
        
        # Apply power management based on current power state
        /home/heisenberg/.config/scripts/battery-power-manager.sh
        ;;
esac
