## create a domain controller
provider "vsphere" {
    user = "${var.username}"
    password = "${var.password}"
    vsphere_server = "192.168.0.30"
    allow_unverified_ssl = true
}

# Create a folder
data "vsphere_datacenter" "dc" {
    name = "Datacenter"
}
data "vsphere_host" "host" {
    name = "192.168.0.30"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_datastore" "datastore" {
    name = "whatshisname"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_resource_pool" "pool" {
    name = "192.168.0.30/Resources"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_network" "network" {
    name = "testnet1"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_virtual_machine" "template" {
    name = "TEMPLATE_NAME"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
resource "vsphere_virtual_machine" "vm1" {
    name = "mynewmachine"
    folder = "myfolder/mysubfolder"
    resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
    datastore_id = "${data.vsphere_datastore.datastore.id}"
    annotation = "test notes"
    num_cpus = 2
    memory = 4096
    guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
    scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
    wait_for_guest_net_timeout = 0

    network_interface {
        network_id = "${data.vsphere_network.network.id}"
        adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
    }
    disk {
        label = "disk0"
        size = "${data.vsphere_virtual_machine.template.disks.0.size}"
        eagerly_scrub = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
        thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
    }
    clone {
        template_uuid = "${data.vsphere_virtual_machine.template.id}"
        customize {
            windows_options {
                computer_name = "marktest"
                admin_password = "password"
                workgroup = "testWG"
                auto_logon = true
                auto_logon_count = 1
                run_once_command_list = [
                    "net start winrm",
                    "winrm quickstart -force",
                    "winrm set winrm/config @{MaxEnvelopeSizekb=\"100000\"}",
                    "winrm set winrm/config/Service @{AllowUnencrypted=\"true\"}",
                    "winrm set winrm/config/Service/Auth @{Basic=\"true\"}",
                    "netsh advfirewall set allprofiles state off"]
            }
            network_interface {

            }
            network_interface {
                ipv4_address = "192.168.2.1"
                ipv4_netmask = 24
            }
        }
    }
    provisioner "remote_exec" {
        connection {
            host = "${self.guest_ip_addresses.0}"
            type = "winrm"
            user = "administrator"
            password = "password"            
        }
        inline = [
            "net user cedric /add",
            "net localgroup administrators cedric /add"]
    }
    provisioner "file" {
        source = "variables.tf"
        destination = "c:/temp/variables.tf"
        connection {
            type = "winrm"
            user = "administrator"
            password = "password"
        }
    }
    ## example of remotely running powershell script
    # provisioner "remote_exec" {
    #     connection {
    #         host = "${self.guest_ip_addresses.0}"
    #         type = "winrm"
    #         user = "administrator"
    #         password = "password"            
    #     }
    #     inline = [
    #         "cmd /C \"powershell.exe set-executionpolicy remotesigned\"",
    #         "cmd /C \"powershell.exe c:/installer.ps1\""]
    # }

}