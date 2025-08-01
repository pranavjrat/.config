#!/bin/bash

current=$(hyprctl activeworkspace -j | jq -r '.id')

recent=$(hyprctl workspaces -j | jq -r \
  '[.[] | select(.last_focus_time != null and .id != '"$current"')] | sort_by(-.last_focus_time) | .[0].id')

# Debug output
echo "Current workspace: $current"
echo "Recent workspace: $recent"

if [[ -n "$recent" && "$recent" =~ ^[0-9]+$ ]]; then
    hyprctl dispatch workspace "$recent"
else
    echo "No valid recent workspace found."
fi
