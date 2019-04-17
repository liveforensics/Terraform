# simple vsphere example

provider "vsphere" {
    user = "pluralsight@vsphere.local"
    password = "P@ssw0rd"
    vsphere_server = "192.168.0.30"
    allow_unverified_ssl = true
}

# create a folder

data "vsphere_datacenter" "dc" {}
data "vsphere_network" "public" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_virtual_machine" "template" {
  name          = "Windows 7vcx"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
resource "vsphere_folder" "TerraformFrontEnd" {
  path          = "TerraformFrontEnd"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# now create a vm in that folder
resource "vsphere_virtual_machine" "terraform-web" {
  name = "terraform-web"
  folder = "${vsphere_folder.TerraformFrontEnd.path}"
  vcpu = 2
  memory = 4096
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
  cluster = "Resources"


    network_interface {
        network_id   = "${data.vsphere_network.public.id}"
    }

    disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
}