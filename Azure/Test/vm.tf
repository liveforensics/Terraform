resource "azurerm_virtual_machine" "myterraformvm" {
  name                  = "myVM"
  location              = "${var.home_location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.myterraformnic.id}"]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "myvm"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCHNXIekc3utyJ7GualVswh8HAdm6Cspt6CL7vJ1Sii+go+C7Dc2anzuFlsyE9ndGM7MpQXwqdPdvb9FuGs9Vm5B4hnCcviAoGoWcDUaoiubhonMLfALu98v+6SFHh+VZs2pKdp3YBVx5K+6J5zp1G4Vt/4mcYlhwhEnn0n+7G4GFewWfh1XwdjtAx/qlvfNSqNqGgViWYKXeqZquRNaO/2uZMbKL3tivVysyJ2p7oCFDV4zzsb7JVg7P9rECJCVebaurgoMBN1RCCxuTCjadHFjalxWB9fqqZ8TMa6PJURqECh+QqGpbZCEXYp8VysIzLTTLkIjh0fNo/NejfW9YEz"
    }
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${azurerm_storage_account.mystorageaccount.primary_blob_endpoint}"
  }

  tags = {
    environment = "${var.environment_tag}"
  }
}