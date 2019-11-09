provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "rg" {
  name     = "marksResourceGroup"
  location = "uksouth"

  tags {
    environment = "Terraform Demo"
  }
}

resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = "myVnet"
  address_space       = ["10.10.0.0/16"]
  location            = "uksouth"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  tags {
    environment = "Terraform Demo"
  }
}

resource "azurerm_subnet" "myterraformsubnet" {
  name                 = "mySubnet"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.myterraformnetwork.name}"
  address_prefix       = "10.10.2.0/24"
}

resource "azurerm_public_ip" "myterraformpublicip" {
  name                         = "myPublicIP"
  location                     = "uksouth"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "dynamic"

  tags {
    environment = "Terraform Demo"
  }
}
resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "myNetworkSecurityGroup"
  location            = "uksouth"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags {
    environment = "Terraform Demo"
  }
}
resource "azurerm_network_interface" "myterraformnic" {
  name                      = "myNIC"
  location                  = "uksouth"
  resource_group_name       = "${azurerm_resource_group.rg.name}"
  network_security_group_id = "${azurerm_network_security_group.myterraformnsg.id}"

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = "${azurerm_subnet.myterraformsubnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.myterraformpublicip.id}"
  }

  tags {
    environment = "Terraform Demo"
  }
}
resource "azurerm_virtual_machine" "myterraformvm" {
  name                  = "myVM"
  location              = "uksouth"
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
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDP6p46uG/zL2omB/3LFgo2GHL0eLwkYHKnVSwvLzFhnyCgyuyBw1UPcqq5tjdJ6Vwvp+R8zJZosd/xwRYKrpI0nWeGuESnyKJwVyfqYdap78WuYQzY6qe29DC92cz3rh7Kk/dOgKCqpQhnaWaIgnH71aXXaXaDTyRdgmN+KCYNNQkORjjtfIeP8OnX/BApfk1eXmGzlqG/QchBgnjCtsGFtWDSOzUhBbBHnZsV5HOMpOyZoa63xXXoziw5J6qUZgDzWTr7PP6Fq3g2rKYd+rlUp94aZr1VQ8qNO1xcBI8wRaWJtlMP3JAg+gM2DQTxFSC5RM59vL0EBgHx2fEbu1iz"
    }
  }

  tags {
    environment = "Terraform Demo"
  }
}

