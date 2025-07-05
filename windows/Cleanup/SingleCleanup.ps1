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

function CleanupFolders{
    param (
        $Folder
    )
    echo "cleaning $Folder"
    cd $Folder\

    # Move documents
    mv -Force  *.docx .\docs\word\

    mv -Force  *.ppt .\docs\ppts\
    mv -Force  *.pptx .\docs\ppts\

    mv -Force  *pdf .\docs\pdfs\

    mv -Force  *.xlsx .\docs\excel

    mv -Force  *.jpg .\docs\images
    mv -Force  *.JPEG .\docs\images
    mv -Force  *.jpeg .\docs\images

    mv -Force  *.txt .\docs\text_files

}

$scriptFolder=(Get-Item .).FullName

$locations = @(
    [Environment]::GetFolderPath("Desktop"),
    [Environment]::GetFolderPath("MyDocuments"),
    "$HOME\Downloads"
)

foreach ($location in $locations) {
    CreateCleanFolders $location
    CleanupFolders $location
}

Set-Location $scriptFolder
