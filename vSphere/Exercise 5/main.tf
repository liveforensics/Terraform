


# module "folder" {
#   source        = "./modules/folder"
#   datacentre_id = "${data.vsphere_datacenter.dc.id}"
#   folder_name   = "${var.folder_name}"
# }
#
# module "network" {
#   source        = "./modules/network"
#   datacentre_id = "${data.vsphere_datacenter.dc.id}"
#   folder_name   = "${module.folder.folder_id}"
#   host_id       = "${data.vsphere_host.host.id}"
# }
module "client-10" {
  source           = "./modules/client-10"
  datacentre_id    = "${data.vsphere_datacenter.dc.id}"
  # folder_id      = "${module.folder.folder_id}"
  # switch_id = "${module.network.switch_id}"
  network_name     = "VM Network"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  admin_username   = "${var.admin_username}"
  admin_password   = "${var.admin_password}"
}