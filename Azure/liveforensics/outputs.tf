output "public_ip_address" {
  value = "${module.windows-client.azurerm_virtual_machine.client.instances.attributes.fqdn}"
}