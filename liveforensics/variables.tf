variable "tenant_id" {
    type = "string"
    default = "wontwork"
} 

variable "subscription_id" {
    type = "string"
    default = "wontwork"
} 

variable "client_id" {
    type = "string"
    default = "wontwork"
} 

variable "client_secret" {
    type = "string"
    default = "wontwork"
} 

 variable "environment_id" {
     type = "string"
     default = "liveForensicsTest"
 }

 variable "prefix" {
  description = "The Prefix used for all resources in this example"
  default = "liveForensicsTest"
}
variable "location" {
  description = "The Azure Region in which the resources in this example should exist"
  default = "uksouth"
}
variable "username" {
    type = "string"
    default = "wontwork"
} 
variable "password" {
    type = "string"
    default = "wontwork"
} 