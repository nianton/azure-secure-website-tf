variable "name" {
  type        = string
  description = "Azure SQL Server resource name."
}

variable "db_name" {
  type        = string
  description = "Azure SQL Server database resource name."
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

variable "db_admin" {
  type        = string
  description = "Admin username for the Azure SQL Server"
}

variable "db_password" {
  type        = string
  description = "Admin password for the Azure SQL Server"
}

variable "vnet_id" {
  type        = string
  description = "Virtual network id to create the private endpoint in & link the respective private DNS zone."
}

variable "app_subnet_id" {
  type        = string
  description = "The subnet id to create the private endpoint in."
}
