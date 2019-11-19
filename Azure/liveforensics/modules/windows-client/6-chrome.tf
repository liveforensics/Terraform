resource "null_resource" "file-copy-test" {
  provisioner "remote-exec" {
    connection {
      host     = "loveforensics.ukwest.cloudapp.azure.com"
      user     = "colin"
      password = "terraformP@ssw0rd"
      port     = 5985
      https    = false
      timeout  = "1m"
      type     = "winrm"
      # NOTE: if you're using a real certificate, rather than a self-signed one, you'll want this set to `false`/to remove this.
      insecure = false
    }
    inline = [
      "cmd /C \"powershell.exe set-executionpolicy unrestricted\"",
    "cmd /C \"powershell.exe New-Item -Type Directory c:\\deleteme \""]
  }

  # provisioner "remote-exec" {
  #   connection {
  #     host     = "loveforensics.ukwest.cloudapp.azure.com"
  #     user     = "colin"
  #     password = "terraformP@ssw0rd"
  #     port     = 5985
  #     https    = true
  #     timeout  = "1m"
  #     type     = "winrm"
  #     # NOTE: if you're using a real certificate, rather than a self-signed one, you'll want this set to `false`/to remove this.
  #     insecure = false
  #   }

  #   inline = [
  #     "cd C:\\Windows",
  #     "dir",
  #   ]
  # }
  # provisioner "file" {
  #   connection {
  #     host     = "loveforensics.ukwest.cloudapp.azure.com"
  #     type     = "winrm"
  #     user     = "${var.admin_username}"
  #     password = "${var.admin_password}"
  #     timeout  = "5m"
  #     https    = "false"
  #     use_ntlm = "true"
  #     port     = "5985"
  #   }
  #   source      = "E:\\Code\\github\\Terraform\\Azure\\liveforensics\\modules\\windows-client\\downloads\\"
  #   destination = "C:\\users\\colin\\downloads\\"
  # }
  depends_on = ["null_resource.wait-for-domain-to-provision"]
}