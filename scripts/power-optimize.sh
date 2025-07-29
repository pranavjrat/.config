#!/bin/bash
# Power Management Optimization Script

# Force deep sleep mode instead of s2idle
echo deep > /sys/power/mem_sleep

# Disable wake-up for problematic devices
echo disabled > /proc/acpi/wakeup
echo XHCI > /proc/acpi/wakeup  # Disable USB wake-up
echo RP06 > /proc/acpi/wakeup  # Disable PCIe wake-up
echo TXHC > /proc/acpi/wakeup  # Disable Thunderbolt wake-up

# Enable power management for USB devices
for device in /sys/bus/usb/devices/*/power/autosuspend_delay_ms; do
    [ -w "$device" ] && echo 1000 > "$device"
done

for device in /sys/bus/usb/devices/*/power/control; do
    [ -w "$device" ] && echo auto > "$device"
done

# Enable power management for PCI devices
for device in /sys/bus/pci/devices/*/power/control; do
    [ -w "$device" ] && echo auto > "$device"
done

# Audio power management
echo 1 > /sys/module/snd_hda_intel/parameters/power_save

# Enable Wi-Fi power saving
iw dev wlan0 set power_save on 2>/dev/null || true

# CPU frequency scaling
echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# Kernel power management parameters
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
echo 15 > /proc/sys/vm/dirty_expire_centisecs

echo "Power optimization applied"
