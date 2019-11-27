output "public_ip_address" {
  value = "${vsphere_virtual_machine.Win10Client.default_ip_address}"
}
