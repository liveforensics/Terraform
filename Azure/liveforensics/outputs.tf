output "public_ip_address" {
  value = "${module.windows-client.public_ip_address}"
}
output "public_fqdn" {
  value = "${module.windows-client.public_fqdn}"
}