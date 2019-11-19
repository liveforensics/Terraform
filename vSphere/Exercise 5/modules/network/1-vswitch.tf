resource "vsphere_host_virtual_switch" "switch" {
  name           = "vSwitchTest"
  host_system_id = "${var.host_id}"
  ## do this for isolated network
  network_adapters = []
  active_nics      = []
  standby_nics     = []
  ## do this for physically connected switch
  # network_adapters = ["vmnic0", "vmnic1"]
  # active_nics = ["vmnic0"]
  # standby_nics = ["vmnic1"]   
}
resource "vsphere_host_port_group" "pg1" {
  name                = "testnet1"
  host_system_id      = "${var.host_id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.switch.name}"
  vlan_id             = 300
}
resource "vsphere_host_port_group" "pg2" {
  name                = "testnet2"
  host_system_id      = "${var.host_id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.switch.name}"
  vlan_id             = 301
}
