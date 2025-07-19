#!/bin/bash

# --- Configuration ---
if [ -z "$1" ]; then
    myHome="$HOME"
else
    myHome="$1"
fi

downloads="$myHome/Downloads"
desktop="$myHome/Desktop"

# --- Main Functions ---

# Helper function to move files using find for robust pattern matching
moveTo() {
    local source_dir="$1"        # The directory to search in
    local pattern_suffix="$2"    # The file pattern, e.g., "*.pdf"
    local destination_folder="$3" # The destination directory

    mkdir -p "$destination_folder" # Ensure destination folder exists

    # Use 'find' for more robust and reliable pattern matching
    # Redirect stderr to /dev/null to suppress "No such file or directory" errors
    find "$source_dir" -maxdepth 1 -type f -iname "$pattern_suffix" -print0 2>/dev/null | while IFS= read -r -d $'\0' file; do
        if [ -f "$file" ]; then # Double-check if it's a regular file
            echo "Moving '$file' to '$destination_folder'"
            mv "$file" "$destination_folder"
        fi
    done
}

# Functions to move specific file types (these now call moveTo differently)
moveAudio() {
    local from="$1"
    local to="$2"
    local extensions=("mp3" "MP3" "wav" "WAV")
    for ext in "${extensions[@]}"; do
        moveTo "$from" "*.$ext" "$to" # Pass directory, then pattern, then destination
    done
}

moveImages() {
    local from="$1"
    local to="$2"
    local extensions=("jpg" "Jpg" "jpeg" "JPEG" "JPG" "png" "PNG" "heic" "HEIC")
    for ext in "${extensions[@]}"; do
        moveTo "$from" "*.$ext" "$to"
    done
}

movePDFs() {
    local from="$1"
    local to="$2"
    local extensions=("pdf" "PDF")
    for ext in "${extensions[@]}"; do
        moveTo "$from" "*.$ext" "$to"
    done
}

moveConfigs() {
    local from="$1"
    local to="$2"
    local extensions=("xml" "json" "yaml" "yml" "properties" "ini")
    for ext in "${extensions[@]}"; do
        moveTo "$from" "*.$ext" "$to"
    done
}

moveVideos() {
    local from="$1"
    local to="$2"
    local extensions=("MOV" "mov" "mp4" "MP4" "avi" "AVI" "mkv" "MKV")
    for ext in "${extensions[@]}"; do
        moveTo "$from" "*.$ext" "$to"
    done
}

moveMSDocs() {
    local from="$1"
    local to="$2"
    local extensions=("docx" "doc" "txt" "csv" "xlsx" "xls" "pptx" "ppt" "rtf" "odt")
    for ext in "${extensions[@]}"; do
        moveTo "$from" "*.$ext" "$to"
    done # <--- This was the missing 'done' keyword, instead of a misplaced '}'
}

moveZIPs() {
    local from="$1"
    local to="$2"
    local extensions=("zip" "ZIP" "rar" "7z" "tar" "gz" "bz2" "xz")
    for ext in "${extensions[@]}"; do
        moveTo "$from" "*.$ext" "$to"
    done
}

# Functions to remove specific file types
removeCalendarInvites() {
    local from="$1"
    find "$from" -maxdepth 1 -type f -iname "*.ics" -delete 2>/dev/null
}

removeInstallers() {
    local from="$1"
    find "$from" -maxdepth 1 -type f \( -iname "*.msi" -o -iname "*.dmg" -o -iname "*.pkg" \) -delete 2>/dev/null
}

removeHTMLDownloads() {
    local from="$1"
    find "$from" -maxdepth 1 -type f \( -iname "*.html" -o -iname "*.htm" \) -delete 2>/dev/null
}

removeExecutables() {
    local from="$1"
    find "$from" -maxdepth 1 -type f \( -iname "*.exe" -o -iname "*.bin" \) -delete 2>/dev/null
}

removeShortcuts() {
    local from="$1"
    find "$from" -maxdepth 1 -type f -iname "*.lnk" -delete 2>/dev/null
}

# Main cleaning logic for a given directory
cleaning() {
    local source_dir="$1"
    local target_base_dir="$2"

    local images_dir="$target_base_dir/Images"
    local pdfs_dir="$target_base_dir/Pdfs"
    local docs_dir="$target_base_dir/Documents"
    local zips_dir="$target_base_dir/Archives"
    local configs_dir="$target_base_dir/Configs"
    local videos_dir="$target_base_dir/Videos"
    local audio_dir="$target_base_dir/Audio"

    moveImages "$source_dir" "$images_dir"
    movePDFs "$source_dir" "$pdfs_dir"
    moveMSDocs "$source_dir" "$docs_dir"
    moveZIPs "$source_dir" "$zips_dir"
    moveConfigs "$source_dir" "$configs_dir"
    moveVideos "$source_dir" "$videos_dir"
    moveAudio "$source_dir" "$audio_dir"

    removeCalendarInvites "$source_dir"
    removeHTMLDownloads "$source_dir"
    removeExecutables "$source_dir"
    removeInstallers "$source_dir"
    removeShortcuts "$source_dir"
}

cleanDesktop() {
    local misc_dir="$desktop/Misc"
    echo "Organizing desktop folder to   - '$misc_dir"
    cleaning "$desktop" "$misc_dir"
}

cleanDownloads() {
    echo "Organizing downloads folder to - '$downloads'"
    cleaning "$downloads" "$downloads"
}

main() {
    cleanDownloads
    cleanDesktop
}

main
