variable "tenant_id" {
  type    = "string"
  default = "wontwork"
}

variable "subscription_id" {
  type    = "string"
  default = "wontwork"
}

variable "client_id" {
  type    = "string"
  default = "wontwork"
}

variable "client_secret" {
  type    = "string"
  default = "wontwork"
}
variable "prefix" {
  description = "The Prefix used for the Windows Client resources - 12 characters or less"
  default     = "murray"
}
variable "home_location" {
  type    = "string"
  default = "ukwest"
}

variable "environment_tag" {
  type    = "string"
  default = "Azure Standard Deployment"
}
variable "admin_username" {
  description = "The username of the administrator account for both the local accounts, and Active Directory accounts. Example: `myexampleadmin`"
}

variable "admin_password" {
  description = "The password of the administrator account for both the local accounts, and Active Directory accounts. Needs to comply with the Windows Password Policy. Example: `PassW0rd1234!`"
}
