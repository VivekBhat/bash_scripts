$scriptFolder=(Get-Item .).FullName
./create_directories.ps1
Set-Location $scriptFolder
./cleanup_windows.ps1
Set-Location $scriptFolder
