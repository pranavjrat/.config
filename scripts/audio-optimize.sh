#!/bin/bash
# Audio optimization script for Intel Tiger Lake

echo "Applying audio optimizations for Intel Tiger Lake..."

# Apply ALSA hardware optimizations
echo 10 | sudo tee /sys/module/snd_hda_intel/parameters/power_save
echo 0 | sudo tee /sys/module/snd_hda_intel/parameters/power_save_controller

# Restart audio services
systemctl --user restart pipewire pipewire-pulse wireplumber

# Wait for services to start
sleep 5

# Set optimal settings
pactl set-sink-volume @DEFAULT_SINK@ 75%
pactl set-sink-mute @DEFAULT_SINK@ false

# Test audio to wake up the sink
speaker-test -t sine -f 1000 -l 1 -s 1 >/dev/null 2>&1 &
sleep 1
killall speaker-test 2>/dev/null || true

echo "Audio optimizations applied. Stuttering should be reduced."
