
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
        if (-Not (Test-Path $currFolder)) {
            #PowerShell Create directory if not exists
            New-Item $currFolder -ItemType Directory
            Write-Host "$currFolder Created successfully"

        }
    } 
}

CreateCleanFolders "Desktop"
CreateCleanFolders "Downloads"
