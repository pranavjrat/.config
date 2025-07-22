#!/bin/bash

# Ultra-fast instant lock - uses i3lock-color's built-in live blur
# This is the fastest possible lock method

# Use i3lock with color support and live blur (no screenshot needed)
i3lock \
    --blur=5 \
    --clock \
    --indicator \
    --timestr="%H:%M:%S" \
    --datestr="%A, %d %B" \
    --time-size=48 \
    --date-size=24 \
    --time-color=ffffffdd \
    --date-color=ffffff88 \
    --ring-color=ffffff3e \
    --key-hl-color=89b4faff \
    --line-uses-ring \
    --inside-color=ffffff1c \
    --separator-color=22222260 \
    --verif-color=a6e3a1ff \
    --wrong-color=f38ba8ff \
    --modif-color=fab387ff \
    --pass-media-keys \
    --pass-screen-keys \
    --pass-volume-keys \
    --nofork
