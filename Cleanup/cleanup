#!/bin/bash
if [ -z "$1" ]; then
    myHome="$HOME"
else
    myHome="$1"
fi

downloads=$myHome/Downloads
downloadsImageFolder=$downloads/Images
downloadsPDFFolder=$downloads/Pdfs
downloadsZipFolder=$downloads/Zips
downloadsDocsFolder=$downloads/Documents
downloadsConfigFolder=$downloads/Configs

desktop=$myHome/Desktop
moveFolder=$desktop/Misc

desktopScreenshotFolder=$moveFolder/Images
desktopPDFFolder=$moveFolder/SomePDFs
desktopDocsFolder=$moveFolder/Documents
desktopZipFolder=$moveFolder/Zips
desktopConfigFolder=$moveFolder/Configs

cleaning() {
    moveImages $1 "$2/Images"
    movePDFs $1 "$2/Pdfs"
    moveMSDocs $1 "$2/Docs"
    moveZIPs $1 "$2/Zips"
    moveConfigs $1 "$2/Configs"
    moveVideos $1 "$2/Videos"
    moveAudio $1 "$2/Videos"
    removeCalendarInvites $1
    removeHTMLDownloads $1
    removeExecutables $1
    removeInstallers $1
    removeShortcuts $1
}

cleanDesktop() {
    echo "Organizing desktop folder.."
    cleaning $desktop $desktop/Misc
}

cleanDownloads() {
    echo "Organizing downloads folder.."
    cleaning $downloads $downloads
}

removeCalendarInvites() {
    rm -rf $1/*.ics
}

removeInstallers() {
    rm -rf $1/*.msi
    rm -rf $1/*.dmg
}

removeHTMLDownloads() {
    rm -rf $1/*.html
}

removeExecutables() {
    rm -rf $1/*.exe
}

removeShortcuts() {
    rm -rf *.lnk
}

moveTo() {
    mkdir -p $2
    mv $1 $2 2>/dev/null
}

moveAudio() {
    local from="$1"
    local to="$2"
    local extensions=("mp3" "MP3" "wav" "WAV")

    for ext in "${extensions[@]}"; do
        moveTo "$from/*.$ext" "$to"
    done
}

moveImages() {
    local from="$1"
    local to="$2"
    local extensions=("jpg" "Jpg" "jpeg" "JPEG" "JPG" "png" "PNG" "heic" "HEIC")

    for ext in "${extensions[@]}"; do
        moveTo "$from/*.$ext" "$to"
    done
}

movePDFs() {
    local from="$1"
    local to="$2"
    local extensions=("pdf" "PDF")

    for ext in "${extensions[@]}"; do
        moveTo "$from/*.$ext" "$to"
    done
}

moveConfigs() {
    local from="$1"
    local to="$2"
    local extensions=("xml" "json" "yaml" "yml" "properties")

    for ext in "${extensions[@]}"; do
        moveTo "$from/*.$ext" "$to"
    done
}

moveVideos() {
    local from="$1"
    local to="$2"
    local extensions=("MOV" "mov" "mp4" "MP4")

    for ext in "${extensions[@]}"; do
        moveTo "$from/*.$ext" "$to"
    done
}

moveMSDocs() {
    local from="$1"
    local to="$2"
    local extensions=("docx" "txt" "csv" "xlsx" "doc" "pptx")

    for ext in "${extensions[@]}"; do
        moveTo "$from/*.$ext" "$to"
    done
}

moveZIPs() {
    local from="$1"
    local to="$2"
    local extensions=("zip" "ZIP")

    for ext in "${extensions[@]}"; do
        moveTo "$from/*.$ext" "$to"
    done
}

main() {
    echo "Cleaning in progress..."
    cleanDesktop
    cleanDownloads
    # cleaning
    echo "Cleaning done!"
}

main
