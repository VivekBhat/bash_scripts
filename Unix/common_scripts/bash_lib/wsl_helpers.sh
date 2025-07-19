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
