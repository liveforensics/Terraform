resource "null_resource" "nulltest" {
    provisioner "file" {
        connection {
            host = "${vsphere_virtual_machine.vm1.*.guest_ip_addresses.0}"
            type = "winrm"
            user = "username"
            password = "password"
        }
        source = "c:\\temp\\somedocco.txt"
        destination = "c:\\temp\\copy.txt"
    }
}