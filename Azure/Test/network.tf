resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.home_location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  tags = {
    environment = "${var.environment_tag}"
  }
}

resource "azurerm_subnet" "myterraformsubnet" {
  name                 = "mySubnet"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.myterraformnetwork.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "myPublicIP"
  location            = "${var.home_location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  allocation_method   = "Static"

  tags = {
    environment = "${var.environment_tag}"
  }
}

resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "myNetworkSecurityGroup"
  location            = "${var.home_location}"
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

  tags = {
    environment = "${var.environment_tag}"
  }
}

resource "azurerm_network_interface" "myterraformnic" {
  name                      = "myNIC"
  location                  = "${var.home_location}"
  resource_group_name       = "${azurerm_resource_group.rg.name}"
  network_security_group_id = "${azurerm_network_security_group.myterraformnsg.id}"

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = "${azurerm_subnet.myterraformsubnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.myterraformpublicip.id}"
  }

  tags = {
    environment = "${var.environment_tag}"
  }
}