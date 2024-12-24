#!/bin/bash

# Path to i3-resurrect executable, adjust if necessary
i3_resurrect="/usr/bin/i3-resurrect"

# Save all workspaces
for i in {1..10}; do
    $i3_resurrect restore -w $i --layout-only 
done
