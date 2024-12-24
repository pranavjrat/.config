#!/usr/bin/env bash

# Ensure the script is being run on an Arch-based system
if [ ! -f /etc/arch-release ]; then
    echo "This script only works on Arch-based systems."
    exit 1
fi

pkg_installed() {
    pacman -Qq "$1" &> /dev/null
}

update_system() {
    echo "Starting the system update..."

    # Update Official packages
    echo "Updating Official packages..."
    pacman -Syu --noconfirm

    # Update AUR packages
    if pkg_installed yay; then
        echo "Updating AUR packages using yay..."
        yay -Syu --noconfirm
    elif pkg_installed paru; then
        echo "Updating AUR packages using paru..."
        paru -Syu --noconfirm
    else
        echo "AUR helper not installed, skipping AUR updates."
    fi

    # Update Flatpak packages
    if pkg_installed flatpak; then
        echo "Updating Flatpak packages..."
        flatpak update -y
    else
        echo "Flatpak not installed, skipping Flatpak updates."
    fi

    echo "System update completed."
}

# Check for Official updates
if pkg_installed pacman-contrib; then
    ofc=$( (while pgrep -x checkupdates > /dev/null ; do sleep 1; done) ; checkupdates | wc -l)
else
    echo "pacman-contrib not installed; please install it to check for updates. Skipping Official updates."
    ofc="Not checked"
fi

# Check for AUR updates
if pkg_installed yay; then
    aur=$(yay -Qua | wc -l)
elif pkg_installed paru; then
    aur=$(paru -Qua | wc -l)
else
    aur="AUR helper not installed"
fi

# Check for Flatpak updates
if pkg_installed flatpak; then
    fpk=$(flatpak remote-ls --updates | wc -l)
else
    fpk="Flatpak not installed"
fi

# Output the update status
echo "[Official] $ofc"
echo "[AUR]      $aur"
echo "[Flatpak]  $fpk"

# Automatically proceed with the update
update_system

