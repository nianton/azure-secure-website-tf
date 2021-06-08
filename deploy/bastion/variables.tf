variable "name" {
  type        = string
  description = "Azure SQL Server resource name."
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name containing this module resources."
}

variable "location" {
  type        = string
  description = "The Azure location/region for the deployment of this module resources."
}

variable "tags" {
  description = "The tags to be applied to the resources created."
}

variable "subnet_id" {
  type = string
  description = "The subnet id to host Bastion, should be named 'AzureBastionSubnet'."
}