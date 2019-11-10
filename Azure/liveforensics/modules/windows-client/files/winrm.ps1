# $Cert = New-SelfSignedCertificate -DnsName $RemoteHostName, $ComputerName `
#     -CertStoreLocation "cert:\LocalMachine\My" `
#     -FriendlyName "Test WinRM Cert"

# $Cert | Out-String

# $Thumbprint = $Cert.Thumbprint

# Write-Host "Enable HTTPS in WinRM"
# $WinRmHttps = "@{Hostname=`"$RemoteHostName`"; CertificateThumbprint=`"$Thumbprint`"}"
# winrm create winrm/config/Listener?Address=*+Transport=HTTPS $WinRmHttps

# Write-Host "Set Basic Auth in WinRM"
# $WinRmBasic = "@{Basic=`"true`"}"
# winrm set winrm/config/service/Auth $WinRmBasic

# Write-Host "Open Firewall Port"
# netsh advfirewall firewall add rule name="Windows Remote Management (HTTPS-In)" dir=in action=allow protocol=TCP localport=5985
Write-Host "Enabling WinRM - I hope **************************************************************************************************************" | Out-File c:\terraform\log.txt
Enable-PSRemoting -Force

Write-Host "Open Firewall Port"
netsh advfirewall firewall add rule name="Windows Remote Management (HTTPS-In)" dir=in action=allow protocol=TCP localport=5985
Start-Service "WinRM"
# Set-NetFirewallRule -DisplayGroup "Terraform" -Enabled True -Profile Public
New-NetFirewallRule -DisplayName "Allow Terraforming" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 5985
# Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False