# Fuzzel File Search - Super+Space

## Quick Start
Press **Super+Space** to open fuzzel file search and quickly find and open files.

## Features
- **Fast Search**: Searches up to 3 levels deep in your home directory
- **Smart Caching**: Results cached for 30 minutes for instant access
- **Clean Interface**: Shows only filenames for easy browsing
- **File Type Filter**: Shows common file types (documents, code, media)
- **Smart Opening**: Opens files with appropriate applications
- **Folder Access**: Option to browse to file location in file manager

## Supported File Types
- **Documents**: .txt, .md, .pdf, .doc, .docx
- **Code**: .sh, .py, .js, .ts, .html, .css, .json, .rs, .go, .c, .cpp, .java
- **Config**: .conf, .cfg, .toml, .yaml, .yml
- **Media**: .jpg, .jpeg, .png, .gif, .mp4, .mkv, .mp3, .flac, .wav, .ogg

## Performance
- **Cache Duration**: 30 minutes
- **Max Results**: 500 files
- **Exclusions**: Hidden files, node_modules, cache directories
- **Speed**: Near-instant after initial cache build

## Usage
1. Press **Super+Space**
2. Type to search for files
3. Use arrow keys to navigate
4. Press Enter to select file
5. Choose action:
   - **📄 Open File**: Opens the file with appropriate application
   - **📁 Open Containing Folder**: Opens the folder containing the file
   - **📂 Open File Manager Here**: Same as folder option
6. Press Escape to cancel at any step

## File Opening
- **Text/Code files**: Opens with $EDITOR (or xdg-open if not set)
- **Other files**: Opens with system default application
- **Folder option**: Opens containing directory in Nautilus/Thunar/Dolphin file manager

## Workflow
1. **Find file**: Type filename to search across your home directory
2. **Clean results**: Only filenames shown (no messy file paths)
3. **Select file**: Navigate with arrow keys, press Enter
4. **Choose action**: Open file directly or browse to its location in file manager
5. **Quick access**: Perfect for both opening files and navigating to their folders

## Cache Location
- Cache stored at: `/tmp/fuzzel-file-cache-$(id -u)`
- Auto-refreshes every 30 minutes
- Manual refresh: delete cache file

Enjoy fast file searching with Super+Space! 🚀
