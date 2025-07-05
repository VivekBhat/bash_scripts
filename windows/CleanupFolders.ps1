function CleanupFolders{
    param (
        $Folder
    )
    echo "cleaning $Folder"
    cd $HOME\$Folder\

    mv *.docx .\docs\word\

    mv *.ppt .\docs\ppts\
    mv *.pptx .\docs\ppts\

    mv *pdf .\docs\pdfs\

    mv *.xlsx .\docs\excel

    mv *.jpg .\docs\images
    mv *.JPEG .\docs\images
    mv *.jpeg .\docs\images

    mv *.txt .\docs\text_files

    rm *.lnk
}

CleanupFolders "Desktop"
CleanupFolders "Downloads"
