Use this script to keep your machine active


```powershell
Clear-Host
Echo "Scroll Lock..."

$WShell = New-Object -com "Wscript.Shell"
$v=0
while ($true)
{
  Write-Host "$v minutes"
  $WShell.sendkeys("{SCROLLLOCK}")
  Start-Sleep -Milliseconds 100
  $WShell.sendkeys("{SCROLLLOCK}")
  Start-Sleep -Seconds 180
  $v+=3
}

```


To run script for n minutes, run the following script

```powershell
Clear-Host

$WShell = New-Object -com "Wscript.Shell"
$count=0
$waitUntilMinutes= 60  # Set your desired threshold here

$startTime = Get-Date -Format "hh:mm:ss tt"
$stopTime = (Get-Date).AddMinutes($waitUntilMinutes).ToString("hh:mm:ss tt")

Write-Host "==================================================="
Write-Host "Pressing Scroll Lock for $waitUntilMinutes minutes"
Write-Host "Start Time          - $startTime"
Write-Host "Estimated Stop Time - $stopTime"
Write-Host "==================================================="
Write-Host ""
while ($count -lt $waitUntilMinutes)
{
  Write-Host "$startTime - $count minutes elapsed"
  $WShell.sendkeys("{SCROLLLOCK}")
  Start-Sleep -Milliseconds 100
  $WShell.sendkeys("{SCROLLLOCK}")
  Start-Sleep -Seconds 60
  $count++
}

Write-Host ""

$endTime = Get-Date -Format "hh:mm:ss tt"

Write-Host "==================================================="
Write-Host "Ran for $waitUntilMinutes minutes. Stopping..."
Write-Host "End Time - $endTime"
Write-Host "==================================================="
```