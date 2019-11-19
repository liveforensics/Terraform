output "public_ip_address" {
  value = "${azurerm_public_ip.static.ip_address}"
}
output "admin_username" {
  value = "${var.admin_username}"
}
output "admin_password" {
  value = "${var.admin_password}"
}
output "public_fqdn" {
  value = "${azurerm_public_ip.static.fqdn}"
}