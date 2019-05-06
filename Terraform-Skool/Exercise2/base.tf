provider "vsphere" {
    user = "${var.username}"
    password = "${var.password}"
    vsphere_server = "192.168.0.30"
    allow_unverified_ssl = true
}

# Create a folder
data "vsphere_datacenter" "dc" {
    name = "Datacenter"
}
resource "vsphere_folder" "folder" {
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
  type = "vm"
  path = "MarksTestFolder"
}
