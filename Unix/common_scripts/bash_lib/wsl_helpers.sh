#!/bin/bash

mount_g() {
    echo "Mounting G: drive to /mnt/g"
    mkdir -p /mnt/g
    sudo mount -t drvfs G: /mnt/g
}

mount_mit_adsp() {
    mount_g

    tgt="/mnt/g/My Drive/Documents/_Vivek/School/05_MIT_ADSP/Resources"
    lnk="/home/vivekbhat/Projects/private/mit_adsp/GoogleDriveResources"

    mkdir -p "$tgt"

    # Create or update the symlink if it doesn't exist or is incorrect
    [ -L "$lnk" ] && [ "$(readlink "$lnk")" = "$tgt" ] || ln -sf "$tgt" "$lnk"

    code /home/vivekbhat/Projects/private/mit_adsp  # Open project in VS Code
}
delete_zone_files() {
    local recursive=false
    local target_directory=""

    # Parse arguments
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -r)
                recursive=true
                shift
                ;;
            *)
                target_directory="$1"
                shift
                ;;
        esac
    done

    # Check if a directory was provided
    if [ -z "$target_directory" ]; then
        echo "Usage: delete_zone_files [-r] /path/to/directory"
        return 1
    fi

    # Check if the provided path is a valid directory
    if [ ! -d "$target_directory" ]; then
        echo "Error: Directory '$target_directory' not found."
        return 1
    fi

    local find_depth_option=""
    if [ "$recursive" = false ]; then
        find_depth_option="-maxdepth 1"
        echo "Searching for and deleting files in '$target_directory' (non-recursive)..."
    else
        echo "Searching for and deleting files in '$target_directory' and its subdirectories (recursive)..."
    fi

    # Find and delete files ending with ':Zone.Identifier'
    # The -print0 and xargs -0 are used to handle filenames with spaces or special characters correctly.
    find "$target_directory" $find_depth_option -type f -name "*:Zone.Identifier" -print0 | while IFS= read -r -d $'\0' file; do
        echo "Deleting: $file"
        rm -f "$file"
    done

    # Find and delete files ending with ':PG$Secure'
    find "$target_directory" $find_depth_option -type f -name "*:PG\$Secure" -print0 | while IFS= read -r -d $'\0' file; do
        echo "Deleting: $file"
        rm -f "$file"
    done

    echo "Deletion process complete."
}
