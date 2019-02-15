resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "${var.prefix}Vnet"
    address_space       = ["10.10.0.0/16"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"

    tags {
        environment = "${var.environment_id}"
    }
}

resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "${var.prefix}Subnet"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.myterraformnetwork.name}"
    address_prefix       = "10.10.2.0/24"
}

resource "azurerm_public_ip" "main" {
    name                         = "${var.prefix}PublicIP"
    location                     = "${var.location}"
    resource_group_name          = "${azurerm_resource_group.rg.name}"
    allocation_method = "Dynamic"

    tags {
        environment = "${var.environment_id}"
    }
}
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "${var.prefix}SecurityGroup"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"

    security_rule {
        name                       = "RDP"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags {
        environment = "${var.environment_id}"
    }
}
resource "azurerm_network_interface" "myterraformnic" {
    name                = "${var.prefix}NIC"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    network_security_group_id = "${azurerm_network_security_group.myterraformnsg.id}"

    ip_configuration {
        name                          = "${var.prefix}NicConfiguration"
        subnet_id                     = "${azurerm_subnet.myterraformsubnet.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          = "${azurerm_public_ip.main.id}"
    }

    tags {
        environment = "${var.environment_id}"
    }
}