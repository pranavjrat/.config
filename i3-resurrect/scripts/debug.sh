#!/bin/bash

# Create layout and program files for workspaces 1 to 9
for i in {1..9}; do
  for type in layout programs; do
    filename="workspace_${i}_${type}.json"
    cat > "$filename" <<EOF
{
  "note": "polybar online/offline toggle",
  "last_updated": "May 11, 2025"
}
EOF
  done
done

