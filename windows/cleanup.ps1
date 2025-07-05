$scriptFolder=(Get-Item .).FullName
./CreateCleanFolders.ps1
Set-Location $scriptFolder
./CleanupFolders.ps1
Set-Location $scriptFolder
