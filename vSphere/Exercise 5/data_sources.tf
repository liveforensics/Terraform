data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}
data "vsphere_host" "host" {
  name          = "192.168.0.21"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_resource_pool" "pool" {
  name          = "marks"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}