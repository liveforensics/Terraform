provider "vsphere" {
  user                 = "${var.username}"
  password             = "${var.password}"
  vsphere_server       = "vsphere.marksworld.net"
  allow_unverified_ssl = true
}