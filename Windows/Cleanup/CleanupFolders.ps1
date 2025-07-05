function CleanupFolders{
    param (
        $Folder
    )
    echo "cleaning $Folder"
    cd $Folder\

    mv -Force  *.docx .\docs\word\

    mv -Force  *.ppt .\docs\ppts\
    mv -Force  *.pptx .\docs\ppts\

    mv -Force  *pdf .\docs\pdfs\

    mv -Force  *.xlsx .\docs\excel

    mv -Force  *.jpg .\docs\images
    mv -Force  *.JPEG .\docs\images
    mv -Force  *.jpeg .\docs\images

    mv -Force  *.txt .\docs\text_files

    rm *.lnk
}

$desktopPath = [Environment]::GetFolderPath("Desktop")
$documentsPath = [Environment]::GetFolderPath("MyDocuments")

CleanupFolders $desktopPath
CleanupFolders $documentsPath
CleanupFolders "$HOME\Downloads"

# CleanupFolders "$HOME\OneDrive - Microsoft\Desktop"
# CleanupFolders "$HOME\Downloads"
