#!/bin/bash

mount_g(){
    echo "Mounting 'G: drive' to /mnt/g"
    mkdir -p /mnt/g
    sudo mount -t drvfs G: /mnt/g
}

mount_gl(){
    mount_g
    GL_FOLDER="/home/vivekbhat/Projects/private/GL"
    TARGET="$GL_FOLDER/GoogleDriveResources"
    SOURCE="/mnt/g/My Drive/Documents/_Vivek/School/05_MIT_ADSP/Resources"

    # Check if the target path does not exist
    if [ ! -e "$TARGET" ]; then
        ln -s "$SOURCE" "$TARGET"
        echo "Symbolic link created: $TARGET → $SOURCE"
    else
        echo "Path already exists: $TARGET"
    fi
    echo "Opening $GL_FOLDER in VSCode"
    code $GL_FOLDER
}
