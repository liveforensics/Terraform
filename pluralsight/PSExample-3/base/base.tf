# simple vsphere example

provider "vSphere" {
    user = "pluralsight@vsphere.local"
    password = "P@ssw0rd"
    vsphere_server = "192.168.0.30"
    allow_unverified_ssl = true
}