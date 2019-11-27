variable "datacentre_id" {}

# variable "folder_id" {}
# variable "switch_id" {}
variable "resource_pool_id" {}
variable "datastore_id" {}
variable "network_name" {}
variable "admin_username" {
  description = "The username of the administrator account for both the local accounts, and Active Directory accounts. Example: `myexampleadmin`"
}

variable "admin_password" {
  description = "The password of the administrator account for both the local accounts, and Active Directory accounts. Needs to comply with the Windows Password Policy. Example: `PassW0rd1234!`"
}
