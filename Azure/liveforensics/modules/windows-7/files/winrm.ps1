Write-Host "Enabling WinRM - I hope"

$profiles = Get-NetConnectionProfile
Foreach ($i in $profiles) {
    Write-Host ("Updating Interface ID {0} to be Private.." -f $profiles.InterfaceIndex)
    Set-NetConnectionProfile -InterfaceIndex $profiles.InterfaceIndex -NetworkCategory Private
}


Enable-PSRemoting -Force -SkipNetworkProfileCheck
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
Set-Item WSMan:\localhost\MaxTimeoutms -value "1800000"
Set-Item WSMan:\localhost\Service\AllowUnencrypted -value $true
winrm get winrm/config >> c:\terraform\winrm.log
Restart-Service "WinRM"
