variable "name" {
  type        = string
  description = "Private DNS zone name."
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name containing this module resources."
}

variable "vnet_id" {
  type = string
  description = "The virtual network id to link the private DNS zone with."
}

variable "tags" {
  description = "The tags to be applied to the resources created."
}