resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  dns_servers         = ["10.0.1.4", "8.8.8.8"]
  tags = {
    environment = "${var.environment_tag}"
  }
}
resource "azurerm_subnet" "domain-controllers" {
  name                 = "domain-controllers"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_subnet" "domain-clients" {
  name                 = "domain-clients"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.2.0/24"
}
