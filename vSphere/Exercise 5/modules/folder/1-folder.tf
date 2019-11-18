resource "vsphere_folder" "folder" {
  datacenter_id = "${var.datacentre_id}"
  type          = "vm"
  path          = "${var.folder_name}"
}
