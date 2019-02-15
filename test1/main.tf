provider "azurerm" {
  subscription_id = "4dcbed93-ddd0-42a0-aa79-44208d362580"
  client_id       = "537ea2b6-90d7-47ae-ba44-fe9ab5887b91"
  client_secret   = "3388191b-9694-44ad-a90d-e791eb04a90c"
  tenant_id       = "4e73027a-db9b-4958-9a63-06330ea6e88f"
}

# locals {
#   virtual_machine_name = "${var.prefix}vm"
# }

# # Locate the existing custom/golden image
# data "azurerm_image" "search" {
#   name                = "${var.image_name}"
#   resource_group_name = "${var.image_resource_group}"
# }

# output "image_id" {
#   value = "${data.azurerm_image.search.id}"
# }

# # Create a Resource Group for the new Virtual Machine.
# resource "azurerm_resource_group" "main" {
#   name     = "${var.prefix}-resources"
#   location = "${var.location}"
# }