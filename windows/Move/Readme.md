Use this script to keep your machine active


```
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
