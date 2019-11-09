provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}
locals {
  resource_group_name = "${var.prefix}-resources"
}
resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_group_name}"
  location = "${var.home_location}"

  tags = {
    environment = "${var.environment_tag}"
  }
}

module "network" {
  source              = "./modules/network"
  prefix              = "${var.prefix}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  environment_tag     = "${var.environment_tag}"
}
module "active-directory-domain" {
  source                        = "./modules/active-directory"
  resource_group_name           = "${azurerm_resource_group.rg.name}"
  location                      = "${azurerm_resource_group.rg.location}"
  prefix                        = "${var.prefix}"
  subnet_id                     = "${module.network.domain_controllers_subnet_id}"
  active_directory_domain       = "${var.prefix}.local"
  active_directory_netbios_name = "${var.prefix}"
  admin_username                = "${var.admin_username}"
  admin_password                = "${var.admin_password}"
}
module "windows-client" {
  source                    = "./modules/windows-client"
  resource_group_name       = "${azurerm_resource_group.rg.name}"
  location                  = "${azurerm_resource_group.rg.location}"
  prefix                    = "${var.prefix}"
  subnet_id                 = "${module.network.domain_clients_subnet_id}"
  active_directory_domain   = "${var.prefix}.local"
  active_directory_username = "${var.admin_username}"
  active_directory_password = "${var.admin_password}"
  admin_username            = "${var.admin_username}"
  admin_password            = "${var.admin_password}"
}