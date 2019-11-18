data "vsphere_network" "network" {
  name          = "${var.network_name}"
  datacenter_id = "${var.datacentre_id}"
}
data "vsphere_virtual_machine" "template" {
  name          = "Windows 10 x64 1903 Template"
  datacenter_id = "${var.datacentre_id}"
}

resource "vsphere_virtual_machine" "Win10Client" {
  name                       = "Win10Client"
  folder                     = "${var.folder_name}"
  resource_pool_id           = "${var.resource_pool_id}"
  datastore_id               = "${var.datastore_id}"
  annotation                 = "test notes"
  num_cpus                   = 2
  memory                     = 4096
  guest_id                   = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type                  = "${data.vsphere_virtual_machine.template.scsi_type}"
  wait_for_guest_net_timeout = 0

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    customize {
      windows_options {
        computer_name    = "${var.admin_username}"
        admin_password   = "${var.admin_password}"
        workgroup        = "testWG"
        auto_logon       = true
        auto_logon_count = 1
      }
      network_interface {

      }
      network_interface {
        ipv4_address = "192.168.2.1"
        ipv4_netmask = 24
      }
    }
  }
}