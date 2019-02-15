provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "rg" {
        name = "${var.prefix}RG"
        location = "${var.location}"

        tags {
        environment = "${var.environment_id}"
    }
}
