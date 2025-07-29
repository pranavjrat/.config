#!/bin/bash
# Optimized launcher for multimedia applications

# Set environment variables for better performance
export MESA_LOADER_DRIVER_OVERRIDE=iris
export LIBVA_DRIVER_NAME=iHD
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
export XDG_SESSION_TYPE=wayland

# CPU performance
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null 2>&1

# Launch the application
case "$1" in
    "zen")
        echo "Launching Zen Browser with optimizations..."
        /opt/zen-browser-bin/zen-bin --use-gl=desktop --enable-features=VaapiVideoDecoder --disable-features=UseOzonePlatform "$@"
        ;;
    "elisa")
        echo "Launching Elisa with optimizations..."
        QT_SCALE_FACTOR=1 elisa "$@"
        ;;
    *)
        echo "Usage: $0 {zen|elisa} [additional args]"
        echo "Example: $0 zen"
        echo "Example: $0 elisa"
        ;;
esac
