#!/bin/bash

# Script to save current workspace state before locking
# This can be useful for restoring window positions or other state

# Create ~/.scripts directory if it doesn't exist
mkdir -p ~/.scripts

# Save current workspace
current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
echo "Current workspace: $current_workspace" > ~/.scripts/workspace_state.txt

# Save current time
echo "Locked at: $(date)" >> ~/.scripts/workspace_state.txt

# Optional: Save window tree (uncomment if needed)
# i3-msg -t get_tree > ~/.scripts/window_tree.json

exit 0
