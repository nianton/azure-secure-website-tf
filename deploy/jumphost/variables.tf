variable "name" {
  type        = string
  description = "Bastion host resource name."
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

variable "size" {
  type = string
  default = "Standard_F2"
  description = "The Azure size/sku of the VM"
}

variable "admin_username" {
  type = string
  description = "The username of the administrator account of the VM."
  default = "adminuser"
}

variable "admin_password" {
  type = string
  description = "The password for the admin user of the VM."
}