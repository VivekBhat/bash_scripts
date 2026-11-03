#!/usr/bin/env bash
# Organize the Desktop and Downloads folders by file type.
#
# Safe to run by piping to bash:
#   curl -fsSL <raw-url>/organize.sh | bash
#   curl -fsSL <raw-url>/organize.sh | bash -s -- --dry-run
#
# Or locally:
#   bash organize.sh [--dry-run] [--home DIR] [--no-desktop] [--no-downloads]
#
# What it does (top level of each folder only, hidden files and folders untouched):
#   Downloads/<file>  ->  Downloads/<Category>/<file>
#   Desktop/<file>    ->  Desktop/Misc/<Category>/<file>
#   Calendar invites, installers, web pages, .exe and .lnk files go to the Trash
#   (never deleted outright). Existing files are never overwritten: a numbered
#   suffix is added instead.
#
# Works with macOS bash 3.2 and Linux bash. No prompts, so it is pipe-friendly.

# Everything is inside functions and main runs on the last line, so a
# partially downloaded script does nothing.

set -u

DRY_RUN=0
TARGET_HOME="$HOME"
DO_DESKTOP=1
DO_DOWNLOADS=1
MOVED=0
TRASHED=0

usage() {
    cat <<'USAGE'
Usage: organize.sh [options]
  -n, --dry-run      Show what would happen, change nothing
      --home DIR     Use DIR instead of $HOME
      --no-desktop   Skip the Desktop folder
      --no-downloads Skip the Downloads folder
  -h, --help         Show this help
USAGE
}

parse_args() {
    while [ $# -gt 0 ]; do
        case "$1" in
            -n | --dry-run) DRY_RUN=1 ;;
            --home)
                [ $# -ge 2 ] || { echo "--home needs a directory" >&2; exit 1; }
                TARGET_HOME="$2"
                shift
                ;;
            --no-desktop) DO_DESKTOP=0 ;;
            --no-downloads) DO_DOWNLOADS=0 ;;
            -h | --help) usage; exit 0 ;;
            *) echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
        esac
        shift
    done
}

trash_dir() {
    if [ "$(uname -s)" = "Darwin" ]; then
        echo "$TARGET_HOME/.Trash"
    else
        echo "${XDG_DATA_HOME:-$TARGET_HOME/.local/share}/Trash/files"
    fi
}

# Map a lowercase extension to a category folder, or TRASH, or nothing.
category_for() {
    case "$1" in
        jpg | jpeg | png | gif | heic | webp | svg | bmp | tiff) echo "Images" ;;
        pdf) echo "Pdfs" ;;
        doc | docx | txt | csv | xls | xlsx | ppt | pptx | rtf | md | pages | numbers | key) echo "Documents" ;;
        zip | tar | gz | tgz | rar | 7z) echo "Zips" ;;
        xml | json | yaml | yml | properties | toml | ini) echo "Configs" ;;
        mov | mp4 | m4v | avi | mkv) echo "Videos" ;;
        mp3 | wav | m4a | aac | flac) echo "Audio" ;;
        ics | dmg | pkg | msi | exe | html | htm | lnk) echo "TRASH" ;;
        *) echo "" ;;
    esac
}

# Print a destination path in $1 for file name $2 that does not exist yet.
unique_dest() {
    local dir="$1" name="$2" base ext n=1 candidate
    candidate="$dir/$name"
    if [ ! -e "$candidate" ]; then
        echo "$candidate"
        return
    fi
    case "$name" in
        ?*.*) base="${name%.*}"; ext=".${name##*.}" ;;
        *) base="$name"; ext="" ;;
    esac
    while [ -e "$dir/$base ($n)$ext" ]; do
        n=$((n + 1))
    done
    echo "$dir/$base ($n)$ext"
}

move_file() {
    local src="$1" dest_dir="$2" label="$3" dest
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "  [dry-run] $label: $(basename "$src") -> $dest_dir/"
        return 0
    fi
    mkdir -p "$dest_dir" || return 1
    dest="$(unique_dest "$dest_dir" "$(basename "$src")")"
    if mv -n "$src" "$dest"; then
        echo "  $label: $(basename "$src") -> $dest"
    else
        echo "  ! could not move $src" >&2
        return 1
    fi
}

organize_folder() {
    local folder="$1" dest_root="$2" trash file name ext category
    if [ ! -d "$folder" ]; then
        echo "Skipping $folder (not found)"
        return
    fi
    trash="$(trash_dir)"
    echo "Organizing $folder"

    for file in "$folder"/*; do
        [ -f "$file" ] || continue          # skip folders, missing globs
        name="$(basename "$file")"
        case "$name" in
            .*) continue ;;                 # hidden files
            *.*) ;;
            *) continue ;;                  # no extension
        esac
        ext="$(echo "${name##*.}" | tr '[:upper:]' '[:lower:]')"
        category="$(category_for "$ext")"

        if [ "$category" = "TRASH" ]; then
            move_file "$file" "$trash" "trash" && TRASHED=$((TRASHED + 1))
        elif [ -n "$category" ]; then
            move_file "$file" "$dest_root/$category" "move" && MOVED=$((MOVED + 1))
        fi
    done
}

main() {
    parse_args "$@"

    if [ ! -d "$TARGET_HOME" ]; then
        echo "Home directory not found: $TARGET_HOME" >&2
        exit 1
    fi

    [ "$DRY_RUN" -eq 1 ] && echo "Dry run: nothing will be changed"

    [ "$DO_DESKTOP" -eq 1 ] && organize_folder "$TARGET_HOME/Desktop" "$TARGET_HOME/Desktop/Misc"
    [ "$DO_DOWNLOADS" -eq 1 ] && organize_folder "$TARGET_HOME/Downloads" "$TARGET_HOME/Downloads"

    echo "Done: $MOVED moved, $TRASHED sent to Trash ($(trash_dir))"
}

main "$@"
