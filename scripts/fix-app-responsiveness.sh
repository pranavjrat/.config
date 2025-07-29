#!/bin/bash
# Application responsiveness fix script

echo "Fixing application responsiveness issues..."

# 1. Reset CPU governor to performance for better responsiveness
echo "Setting CPU governor to performance..."
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    [ -w "$cpu" ] && echo performance | sudo tee "$cpu" > /dev/null
done

# 2. Increase I/O scheduler responsiveness
echo "Optimizing I/O scheduler..."
for device in /sys/block/*/queue/scheduler; do
    if [ -w "$device" ]; then
        # Try mq-deadline for better responsiveness
        echo mq-deadline | sudo tee "$device" 2>/dev/null || echo deadline | sudo tee "$device" 2>/dev/null
    fi
done

# 3. Increase file descriptor limits
echo "Increasing file descriptor limits..."
echo "fs.file-max = 2097152" | sudo tee -a /etc/sysctl.conf
echo "* soft nofile 65536" | sudo tee -a /etc/security/limits.conf
echo "* hard nofile 65536" | sudo tee -a /etc/security/limits.conf

# 4. Optimize memory management
echo "Optimizing memory management..."
sudo sysctl vm.swappiness=10
sudo sysctl vm.dirty_ratio=15
sudo sysctl vm.dirty_background_ratio=5

# 5. Fix Wayland/XDG portal issues
echo "Restarting XDG desktop portals..."
systemctl --user restart xdg-desktop-portal
systemctl --user restart xdg-desktop-portal-gtk

# 6. Reset audio system (might affect multimedia apps)
echo "Resetting audio system..."
systemctl --user restart pipewire pipewire-pulse wireplumber

# 7. Clear application caches that might be causing issues
echo "Clearing application caches..."
rm -rf ~/.cache/zen-browser-bin/
rm -rf ~/.cache/elisa/

# 8. Fix Firefox/Zen browser specific issues
echo "Applying Firefox/Zen browser fixes..."
mkdir -p ~/.zen-browser-bin/
cat > ~/.zen-browser-bin/user.js << 'EOL'
// Performance optimizations for Zen Browser
user_pref("layers.acceleration.force-enabled", true);
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.enabled", true);
user_pref("layers.gpu-process.enabled", true);
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.hardware-video-decoding.enabled", true);
user_pref("media.hardware-video-decoding.force-enabled", true);
user_pref("dom.ipc.processCount", 8);
user_pref("browser.tabs.remote.autostart", true);
user_pref("layers.omtp.enabled", true);
EOL

echo "Application responsiveness fixes applied!"
echo "Please restart the affected applications for full effect."
