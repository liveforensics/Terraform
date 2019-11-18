provider "vsphere" {
  user                 = "${var.username}"
  password             = "${var.password}"
  vsphere_server       = "vsphere.marksworld.net"
  allow_unverified_ssl = true
}
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

module "folder" {
  source        = "./modules/folder"
  datacentre_id = "${data.vsphere_datacenter.dc.id}"
  folder_name   = "${var.folder_name}"
}

module "network" {
  source        = "./modules/network"
  datacentre_id = "${data.vsphere_datacenter.dc.id}"
  folder_name   = "${var.folder_name}"
  host_id       = "${data.vsphere_host.host.id}"
}
module "client-10" {
  source           = "./modules/client-10"
  datacentre_id    = "${data.vsphere_datacenter.dc.id}"
  folder_name      = "${var.folder_name}"
  network_name     = "${module.network.network_name}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  admin_username   = "${var.admin_username}"
  admin_password   = "${var.admin_password}"
}