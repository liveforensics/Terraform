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

