locals {
  virtual_machine_name = "${var.prefix}-client"
  virtual_machine_fqdn = "${local.virtual_machine_name}.${var.active_directory_domain}"
  custom_data_params   = "Param($RemoteHostName = \"${local.virtual_machine_fqdn}\", $ComputerName = \"${local.virtual_machine_name}\")"
  custom_data_content  = "${local.custom_data_params} ${file("${path.module}/files/winrm.ps1")}"
}

resource "azurerm_virtual_machine" "client" {
  name                          = "${local.virtual_machine_name}"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  network_interface_ids         = ["${azurerm_network_interface.primary.id}"]
  vm_size                       = "Standard_F2"
  delete_os_disk_on_termination = true

  # az vm image list --all --output table --publisher MicrosoftWindowsDesktop
  storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "19h1-ent"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${local.virtual_machine_name}-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${local.virtual_machine_name}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
    custom_data    = "${local.custom_data_content}"
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true

    additional_unattend_config {
      pass         = "oobeSystem"
      component    = "Microsoft-Windows-Shell-Setup"
      setting_name = "AutoLogon"
      content      = "<AutoLogon><Password><Value>${var.admin_password}</Value></Password><Enabled>true</Enabled><LogonCount>1</LogonCount><Username>${var.admin_username}</Username></AutoLogon>"
    }
    # Unattend config is to enable basic auth in WinRM, required for the provisioner stage.
    additional_unattend_config {
      pass         = "oobeSystem"
      component    = "Microsoft-Windows-Shell-Setup"
      setting_name = "FirstLogonCommands"
      content      = "${file("${path.module}/files/FirstLogonCommands.xml")}"
    }
  }
  # connection {
  #   type     = "winrm"
  #   user     = "${var.admin_username}"
  #   password = "${var.admin_password}"
  #   insecure = true
  #   port     = 5985
  #   https    = true
  #   host     = "${azurerm_public_ip.static.ip_address}"
  #   timeout  = "5m"
  # }
  # # Copies all files and folders in apps/app1 to D:/IIS/webapp1
  # provisioner "file" {
  #   source      = "downloads/"
  #   destination = "C:/Users/colin/Downloads"
  # }
}
# connection {
#       user     = "${local.admin_username}"
#       password = "${local.admin_password}"
#       port     = 5985
#       https    = true
#       timeout  = "10m"

#       # NOTE: if you're using a real certificate, rather than a self-signed one, you'll want this set to `false`/to remove this.
#       insecure = true
#     }