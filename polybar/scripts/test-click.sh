#!/bin/bash
notify-send "WiFi Test" "Script executed successfully!" -i network-wireless
echo "$(date): Test script executed" >> /tmp/polybar-test.log
