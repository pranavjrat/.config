#!/bin/bash

# JARVIS Pywal Integration Script
# Generates JARVIS-themed colors and applies them to the system

# JARVIS color palette
cat > ~/.cache/wal/colors-polybar << 'EOF'
; JARVIS Pywal Colors for Polybar
; AI-themed color scheme

background = #000814
foreground = #00d4ff

color0 = #000814
color1 = #ff0040
color2 = #00ff88
color3 = #ffd700
color4 = #00d4ff
color5 = #ff69b4
color6 = #00ffff
color7 = #ffffff
color8 = #0077b6
color9 = #ff6b35
color10 = #a6e3a1
color11 = #f9e2af
color12 = #89b4fa
color13 = #f5c2e7
color14 = #94e2d5
color15 = #cdd6f4
EOF

# Generate colors for other applications
cat > ~/.cache/wal/colors.sh << 'EOF'
# JARVIS Theme Colors
wallpaper=''

# Special
background='#000814'
foreground='#00d4ff'
cursor='#00d4ff'

# Colors
color0='#000814'
color1='#ff0040'
color2='#00ff88'
color3='#ffd700'
color4='#00d4ff'
color5='#ff69b4'
color6='#00ffff'
color7='#ffffff'
color8='#0077b6'
color9='#ff6b35'
color10='#a6e3a1'
color11='#f9e2af'
color12='#89b4fa'
color13='#f5c2e7'
color14='#94e2d5'
color15='#cdd6f4'

# FZF colors
export FZF_DEFAULT_OPTS="
    $FZF_DEFAULT_OPTS
    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1
"
EOF

# Restart polybar if running
if pgrep -x "polybar" > /dev/null; then
    ~/.config/polybar/launch_polybar.sh &
fi

echo "JARVIS colors applied!"
notify-send "🤖 JARVIS" "Color scheme updated!" -i computer
