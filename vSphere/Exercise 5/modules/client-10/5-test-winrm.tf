resource "null_resource" "winrm-connection-test" {
  provisioner "local-exec" {
    command = <<EOT
      Test-WSMan "${vsphere_virtual_machine.Win10Client.default_ip_address}"
    EOT

    interpreter = ["powershell", "-Command"]
  }

  depends_on = ["null_resource.wait-for-winrm-to-start"]
}
