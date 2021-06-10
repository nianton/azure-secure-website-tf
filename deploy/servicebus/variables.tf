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

variable "sku" {
  description = "The tags to be applied to the resources created."
  default = "Premium"
  validation {
    condition = contains(["Standard", "Premium"], var.sku)
    error_message = "The sku value must be 'Standard' or 'Premium'."
  }
}

variable "tags" {
  description = "The tags to be applied to the resources created."
}

variable "vnet_id" {
  type = string
  description = "Virtual network id to create the private endpoint in & link the respective private DNS zone."
}

variable "subnet_id" {
  type = string
  description = "The subnet id to host the respective private link."
}