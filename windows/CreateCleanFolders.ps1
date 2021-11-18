
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
