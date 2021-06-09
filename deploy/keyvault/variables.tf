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

variable "managed_identity_tenant_id" {
  type        = string
  description = "The website's managed identity Tenant Id to allow access to secrets"
}

variable "managed_identity_object_id" {
  type        = string
  description = "The website's managed identity Object Id to allow access to secrets"
}
