#!/bin/bash

mount_g(){
    echo "Mounting G: drive to /mnt/g"
    mkdir -p /mnt/g
    sudo mount -t drvfs G: /mnt/g
}

mount_gl(){
    mount_g
    # create link to this folder from Drive to WSL: /mnt/g/My Drive/Documents/_Vivek/School/05_MIT_ADSP/Resources
    mkdir -p /mnt/g/My\ Drive/Documents/_Vivek/School/05_MIT_ADSP/Resources
    ln -s /mnt/g/My\ Drive/Documents/_Vivek/School/05_MIT_ADSP/Resources /home/vivekbhat/Projects/private/GL/GoogleDriveResources
}
