variable "username" {
  type    = "string"
  default = "wontwork"
}
variable "password" {
  type    = "string"
  default = "wontwork"
}
variable "admin_username" {
  description = "The username of the administrator account for both the local accounts, and Active Directory accounts. Example: `myexampleadmin`"
}

variable "admin_password" {
  description = "The password of the administrator account for both the local accounts, and Active Directory accounts. Needs to comply with the Windows Password Policy. Example: `PassW0rd1234!`"
}
variable "folder_name" {
  default = "Exercise5"
}