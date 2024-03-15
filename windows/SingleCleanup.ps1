
function CreateCleanFolders{
    param (
        $Folder
    )

    $currDir = "$HOME\$Folder\"
    Set-Location $currDir
    $myFolders = "ppts","pdfs","word","excel","images","text_files"

    $FolderName = "docs"
    Foreach ($i in $myFolders)
    {    
        $currFolder = "$FolderName\$i"
        echo $currDir
        echo $currFolder
        if (-Not (Test-Path $currFolder)) {
            #PowerShell Create directory if not exists
            New-Item $currFolder -ItemType Directory
            Write-Host "$currFolder Created successfully"

        }
    } 
}

CreateCleanFolders "$HOME\OneDrive - Microsoft\Desktop"
CreateCleanFolders "Downloads"

Set-Location $scriptFolder
function CleanFolder{
    param (
        $Folder
    )
    echo "cleaning $HOME\$Folder"
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

CleanFolder "$HOME\OneDrive - Microsoft\Desktop"
CleanFolder "Downloads"

Set-Location $scriptFolder
