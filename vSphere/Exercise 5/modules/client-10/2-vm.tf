data "vsphere_network" "network" {
  name          = "${var.network_name}"
  datacenter_id = "${var.datacentre_id}"
}
data "vsphere_virtual_machine" "template" {
  name          = "Win10 1903 x64"
  datacenter_id = "${var.datacentre_id}"
}

resource "vsphere_virtual_machine" "Win10Client" {
  name                       = "Win10Client"
  folder                     = "Exercise5"
  resource_pool_id           = "${var.resource_pool_id}"
  datastore_id               = "${var.datastore_id}"
  annotation                 = "test notes"
  num_cpus                   = 2
  memory                     = 4096
  guest_id                   = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type                  = "${data.vsphere_virtual_machine.template.scsi_type}"
  firmware                   = "${data.vsphere_virtual_machine.template.firmware}"
  wait_for_guest_net_timeout = 100

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
      # windows_sysprep_text = "${file("${path.module}/files/FirstLogonCommands.xml")}"
      windows_options {
        computer_name    = "${var.admin_username}"
        admin_password   = "${var.admin_password}"
        workgroup        = "terraformsucks"
        auto_logon       = true
        auto_logon_count = 4
        run_once_command_list = [
          "powershell -command \"& {set-executionpolicy unrestricted}\"",
          "powershell -command \"& { $p = Get-NetConnectionProfile; foreach ($i in $p) {Set-NetConnectionProfile -InterfaceIndex $p.InterfaceIndex -NetworkCategory private}} \"",
          "winrm quickconfig -force",
          "winrm set winrm/config @{MaxEnvelopeSizekb=\"100000\"}",
          "winrm set winrm/config/Service @{AllowUnencrypted=\"true\"}",
          "winrm set winrm/config/Service/Auth @{Basic=\"true\"}",
          "Start-Service WinRM",
          "Set-service WinRM -StartupType Automatic",
          "Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled false"
        ]
      }
      network_interface {

      }
      # network_interface {
      #   ipv4_address = "192.168.0.44"
      #   ipv4_netmask = 24
      # }
    }
  }
}