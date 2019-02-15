

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