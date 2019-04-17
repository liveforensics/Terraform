# simple vsphere example

provider "vsphere" {
    user = "pluralsight@vsphere.local"
    password = "P@ssw0rd"
    vsphere_server = "192.168.0.30"
    allow_unverified_ssl = true
}

# create a folder
resource "vsphere_folder" "TerraformFrontEnd" {
  datacenter = "Datacenter"
  path = "TerraformFrontEnd"
}
