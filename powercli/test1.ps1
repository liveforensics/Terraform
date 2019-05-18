cls

$secpasswd = ConvertTo-SecureString "murraykattP@ssw0rd" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("administrator@vsphere.local", $secpasswd)

$connection = Connect-VIServer 192.168.0.30 -Credential $mycreds

if($connection.IsConnected)
{
    Write-Host "Connected"
    $vm = Get-Vm "Win7-32"
    $here = Get-Location
    $scriptFolder = Join-Path $here 'powercli\scripts'
    Copy-VMGuestFile -Source (Join-Path $scriptFolder 'script1.ps1') -Destination c:\temp\ -VM $vm -localtoguest -GuestUser "mark" -GuestPassword "P@ssw0rd" -Force
    Invoke-VMScript -VM $vm -ScriptText "Enable-PSRemoting -Force" -GuestUser "mark" -GuestPassword "P@ssw0rd"


}
Disconnect-VIServer 192.168.0.30 -Force -Confirm:$false