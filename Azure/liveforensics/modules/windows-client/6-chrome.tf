resource "null_resource" "file-copy-test" {
  provisioner "remote-exec" {
    connection {
      host     = "loveforensics.ukwest.cloudapp.azure.com"
      type     = "winrm"
      user     = "colin"
      port     = "5985"
      password = "terraformP@ssw0rd"
      timeout  = "5m"
      https    = "false"
      use_ntlm = "true"
    }
    inline = [
      "cmd /C \"powershell.exe set-executionpolicy unrestricted\"",
    "cmd /C \"powershell.exe New-Item -Type Directory c:\\deleteme \""]
  }

  provisioner "file" {
    connection {
      host     = "loveforensics.ukwest.cloudapp.azure.com"
      type     = "winrm"
      user     = "${var.admin_username}"
      password = "${var.admin_password}"
      timeout  = "5m"
      https    = "false"
      use_ntlm = "true"
      port     = "5985"
    }
    source      = "/downloads/"
    destination = "C:\\users\\colin\\downloads\\"
  }
  depends_on = ["null_resource.wait-for-domain-to-provision"]
}