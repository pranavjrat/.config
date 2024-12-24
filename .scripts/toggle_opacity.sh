#!/bin/bash

# Define file locations
PICOM_CONFIG="$HOME/.config/picom/picom.conf"

# Check the current opacity setting
if grep -q "opacity-rule" "$PICOM_CONFIG"; then
    # If opacity is already set, change to fully opaque
    sed -i 's/opacity-rule = \[.*\]/opacity-rule = [ "100:class_g = 'URxvt'", "100:class_g = 'Alacritty'" ]/' "$PICOM_CONFIG"
else
    # If opacity is not set, set it to 80% for transparency
    sed -i 's/opacity-rule = \[.*\]/opacity-rule = [ "80:class_g = 'URxvt'", "80:class_g = 'Alacritty'" ]/' "$PICOM_CONFIG"
fi

# Restart picom to apply changes
pkill picom
picom &

