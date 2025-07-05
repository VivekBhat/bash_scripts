$scriptFolder=(Get-Item .).FullName

function CreateCleanFolders{
    param (
        $CurrDirectory
    )
    Set-Location $CurrDirectory
    $myFolders = "ppts","pdfs","word","excel","images","text_files"

    $FolderName = "docs"
    Foreach ($i in $myFolders)
    {    
        $currFolder = "$FolderName\$i"
        if (-Not (Test-Path $currFolder)) {
            #PowerShell Create directory if not exists
            New-Item $currFolder -ItemType Directory
            Write-Host "$currFolder Created successfully"

        }
    } 
    Set-Location $CurrDirectory
}

CreateCleanFolders "$HOME\OneDrive - Microsoft\Desktop"
CreateCleanFolders "$HOME\Downloads"

Set-Location $scriptFolder

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

Set-Location $scriptFolder
