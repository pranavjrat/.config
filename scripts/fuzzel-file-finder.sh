#!/bin/bash

# Fuzzel File Finder Script
# Fast file search using fuzzel

# Configuration
HOME_DIR="$HOME"
MAX_DEPTH=3
CACHE_FILE="/tmp/fuzzel-file-cache-$(id -u)"
CACHE_AGE_MINUTES=30

# Check if cache is fresh (less than 30 minutes old)
is_cache_fresh() {
    if [[ -f "$CACHE_FILE" ]]; then
        local cache_age=$(( ($(date +%s) - $(stat -c %Y "$CACHE_FILE")) / 60 ))
        [[ $cache_age -lt $CACHE_AGE_MINUTES ]]
    else
        return 1
    fi
}

# Generate file list
generate_file_list() {
    find "$HOME_DIR" -maxdepth $MAX_DEPTH -type f \
        -not -path "*/.*" \
        -not -path "*/node_modules/*" \
        -not -path "*/.cache/*" \
        -not -path "*/.local/*" \
        -not -path "*/Cache/*" \
        -not -path "*/CachedData/*" \
        2>/dev/null | \
    grep -E '\.(txt|md|pdf|doc|docx|jpg|jpeg|png|gif|mp4|mkv|mp3|flac|wav|ogg|sh|py|js|ts|html|css|json|conf|cfg|toml|yaml|yml|rs|go|c|cpp|java)$' | \
    head -500 | \
    sort
}

# Format file list for display (filename only)
format_file_list() {
    while IFS= read -r filepath; do
        local filename=$(basename "$filepath")
        echo "$filename"
    done
}

# Find full path from filename
find_full_path() {
    local filename="$1"
    get_file_list | grep "/$filename$" | head -1
}

# Get file list (cached or fresh)
get_file_list() {
    if is_cache_fresh; then
        cat "$CACHE_FILE"
    else
        generate_file_list > "$CACHE_FILE"
        cat "$CACHE_FILE"
    fi
}

# Open file with appropriate application
open_file() {
    local file="$1"
    local extension="${file##*.}"
    
    case "${extension,,}" in
        txt|md|sh|py|js|ts|html|css|json|conf|cfg|toml|yaml|yml|rs|go|c|cpp|java)
            # Open with editor
            if [[ -n "$EDITOR" ]]; then
                $EDITOR "$file" &
            else
                xdg-open "$file" &
            fi
            ;;
        *)
            # Open with default application
            xdg-open "$file" &
            ;;
    esac
}

# Main execution
main() {
    # Get file list and show only filenames to user
    local selected_filename
    selected_filename=$(get_file_list | format_file_list | fuzzel --dmenu --prompt "📁 File: " --width 40 --lines 15)
    
    if [[ -n "$selected_filename" ]]; then
        # Find the full path for the selected filename
        local selected_file
        selected_file=$(find_full_path "$selected_filename")
        
        if [[ -n "$selected_file" && -f "$selected_file" ]]; then
            local folder=$(dirname "$selected_file")
            
            # Show action choices with context
            local choice
            choice=$(echo -e "📄 Open File: $selected_filename\n📁 Open Folder: $folder\n📂 Browse to Location" | fuzzel --dmenu --prompt "Action: " --width 40 --lines 3)
            
            case "$choice" in
                "📄 Open File:"*)
                    open_file "$selected_file"
                    ;;
                "📁 Open Folder:"*|"📂 Browse to Location")
                    # Open the containing folder in file manager
                    if command -v nautilus >/dev/null 2>&1; then
                        nautilus "$folder" &
                    elif command -v thunar >/dev/null 2>&1; then
                        thunar "$folder" &
                    elif command -v nemo >/dev/null 2>&1; then
                        nemo "$folder" &
                    elif command -v dolphin >/dev/null 2>&1; then
                        dolphin "$folder" &
                    else
                        # Fallback to xdg-open
                        xdg-open "$folder" &
                    fi
                    ;;
                *)
                    # Default action: open file (if user cancels, do nothing)
                    ;;
            esac
        fi
    fi
}

# Run if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
