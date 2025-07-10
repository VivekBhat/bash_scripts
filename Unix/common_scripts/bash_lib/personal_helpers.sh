#!/bin/bash

mount_g(){
    echo "Mounting 'G: drive' to /mnt/g"
    mkdir -p /mnt/g
    sudo mount -t drvfs G: /mnt/g
}

mount_h() {
    echo "Mounting H: drive to /mnt/h"
    mkdir -p /mnt/h
    sudo mount -t drvfs H: /mnt/h
}

mount_gl() {
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

mount_ai_cohort() {
    mount_h
    # create link to this folder from Drive to WSL: /mnt/g/My Drive/Documents/_Vivek/School/05_MIT_ADSP/Resources
    ln -s /mnt/h/My\ Drive/Network\ and\ Operations\ Resources /home/vivekbhat/Projects/private/ai_cohort_denver/GoogleDriveResources
    code /home/vivekbhat/Projects/private/ai_cohort_denver
}
