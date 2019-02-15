# Create a folder
data "vsphere_datacenter" "datacentre" {
    name = "dc1"
}
resource "vsphere_folder" "TerraformFrontEnd" {
  datacenter_id = "${data.vsphere_datacenter.datacentre.id}"
  type = "vm"
  path = "TerraformFrontEnd"
}
