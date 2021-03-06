# simple vsphere example

provider "vsphere" {
  user                 = "pluralsight@vsphere.local"
  password             = "passw0rd"
  vsphere_server       = "192.168.0.211"
  allow_unverified_ssl = true
}

# create a folder

data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}
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
  name             = "terraform-web"
  resource_pool_id = "${data.vsphere_datacenter.dc.id}"
  folder           = "${vsphere_folder.TerraformFrontEnd.path}"
  num_cpus         = 2
  memory           = 4096



  network_interface {
    network_id = "${data.vsphere_network.public.id}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
}