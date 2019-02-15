

resource "azurerm_virtual_machine" "myterraformvm" {
    name                  = "${var.prefix}VM"
    location              = "${var.location}"
    resource_group_name   = "${azurerm_resource_group.rg.name}"
    network_interface_ids = ["${azurerm_network_interface.myterraformnic.id}"]
    vm_size               = "Standard_DS1_v2"

    delete_os_disk_on_termination = true
    delete_data_disks_on_termination = true

    storage_os_disk {
        name              = "${var.prefix}OsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "MicrosoftVisualStudio"
        offer     = "VisualStudio"
        sku       = "VS-2017-Ent-Latest-Win10-N"
        version   = "latest"
    }

    os_profile {
        computer_name  = "hostname"
        admin_username = "${var.username}"
        admin_password = "${var.password}"
    }

    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

    tags {
        environment = "${var.environment_id}"
    }
}

# {
#     "offer": "VisualStudio",
#     "publisher": "MicrosoftVisualStudio",
#     "sku": "VS-2017-Ent-Latest-Win10-N",
#     "urn": "MicrosoftVisualStudio:VisualStudio:VS-2017-Ent-Latest-Win10-N:2019.1.11",
#     "version": "2019.1.11"
#   }