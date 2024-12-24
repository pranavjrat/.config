#!/bin/bash

# Define the low battery threshold (in percentage)
LOW_BATTERY_THRESHOLD=20

# Get the current battery percentage and status (Charging/Discharging)
BATTERY_INFO=$(acpi -b)
BATTERY_PERCENT=$(echo "$BATTERY_INFO" | grep -P -o '[0-9]+(?=%)' | head -n 1)
BATTERY_STATUS=$(echo "$BATTERY_INFO" | grep -o 'Charging\|Discharging\|Full')

# Check if the battery percentage is below the threshold and discharging
if [ "$BATTERY_STATUS" == "Discharging" ] && [ "$BATTERY_PERCENT" -le "$LOW_BATTERY_THRESHOLD" ]; then
    # Show a low battery notification
    #echo "Battery is at $BATTERY_PERCENT%. Please plug in your charger or loose your stuff." | \
    #rofi -dmenu -p "Battery Warning:" -theme ~/dotfiles/rofi/.config/rofi/catppuccin-mocha.rasi
    ~/.config/rofi/applets/bin/battery.sh

fi

# Check if the battery is at 100% and still charging
if [ "$BATTERY_STATUS" == "Charging" ] && [ "$BATTERY_PERCENT" -eq 100 ]; then
    # Show a fully charged notification
    #echo "Battery is fully charged at 100%. Please unplug your charger." | \
    #rofi -dmenu -p "Battery Notification:" -theme ~/dotfiles/rofi/.config/rofi/catppuccin-mocha.rasi
    ~/.config/rofi/applets/bin/battery.sh
fi
