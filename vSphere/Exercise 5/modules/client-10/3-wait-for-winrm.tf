resource "null_resource" "wait-for-winrm-to-start" {
  provisioner "local-exec" {
    command = <<EOT
      Write-Host "Waiting for the WinRM Service to come up"
      Start-Sleep 120
      Write-Host "Fed Up Waiting Now.."
    EOT

    interpreter = ["powershell", "-Command"]
  }

  depends_on = ["vsphere_virtual_machine.Win10Client"]
}
