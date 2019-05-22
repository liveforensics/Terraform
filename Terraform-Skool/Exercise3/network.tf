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
    name = "192.168.0.21"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_datastore" "datastore" {
    name = "datastore1"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
# data "vsphere_resource_pool" "pool" {
#     name = "192.168.0.30/Resources"
#     datacenter_id = "${data.vsphere_datacenter.dc.id}"
# }
resource "vsphere_host_virtual_switch" "switch" {
    name = "vSwitchTest"
    host_system_id = "${data.vsphere_host.host.id}"
    ## do this for isolated network
    network_adapters = []
    active_nics = []
    standby_nics = []
    ## do this for physically connected switch
    # network_adapters = ["vmnic0", "vmnic1"]
    # active_nics = ["vmnic0"]
    # standby_nics = ["vmnic1"]   
}
resource "vsphere_host_port_group" "pg1" {
    name = "testnet1"
    host_system_id = "${data.vsphere_host.host.id}"
    virtual_switch_name = "${vsphere_host_virtual_switch.switch.name}"
    vlan_id = 300
}
resource "vsphere_host_port_group" "pg2" {
    name = "testnet2"
    host_system_id = "${data.vsphere_host.host.id}"
    virtual_switch_name = "${vsphere_host_virtual_switch.switch.name}"
    vlan_id = 301
}

