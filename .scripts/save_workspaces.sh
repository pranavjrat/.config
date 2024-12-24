#!/bin/bash

#rm -rf /home/heisenberg/.config/i3-resurrect/workspaces/*
# Path to i3-resurrect executable, adjust if necessary
i3_resurrect="/usr/bin/i3-resurrect"

for i in {1..9}; do
    $i3_resurrect save -w $i 
done

