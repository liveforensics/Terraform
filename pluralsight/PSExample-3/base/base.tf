# simple vsphere example

provider "vsphere" {
    user = "pluralsight@vsphere.local"
    password = "P@ssw0rd"
    vsphere_server = "192.168.0.30"
    allow_unverified_ssl = true
}

# create a folder

data "vsphere_datacenter" "Datacenter" {}

resource "vsphere_folder" "TerraformFrontEnd" {
  path          = "TerraformFrontEnd"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.Datacenter.id}"
}

# now create a vm in that folder
resource "vsphere_virtual_machine" "terraform-web" {
  name = "terraform-web"
  folder = "${vsphere_folder.TerraformFrontEnd.path}"
  vcpu = 2
  memory = 4096
  datacenter_id = "${data.vsphere_datacenter.Datacenter.id}"
  cluster = "Resources"


network-interface {
    label = "DPortGroup"
}

disk {
    datastore = "datastore1"
    template = "Windows 7vcx"
}
}