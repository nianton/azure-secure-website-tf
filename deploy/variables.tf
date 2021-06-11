variable "naming_convention_type" {
  type        = string
  default     = "suffix"
  description = "The naming convention type to be used, with prefix or suffix for the resource type."
  validation {
    condition     = can(regex("^(prefix|suffix)$", var.naming_convention_type))
    error_message = "Must be 'prefix' or 'suffix'."
  }
}

variable "app_name" {
  type        = string
  default     = "secweb"
  description = "The name of the application / service to be deployed in this environment."
}

variable "environment" {
  type        = string
  description = "The name of the environment to be created, e.g. 'dev', 'prod', 'uat' etc"
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "The Azure location/region for the environment to be deployed in."
}

variable "sql_admin_username" {
  type        = string
  description = "The administrator username for the Azure SQL server."
}

variable "jumphost_admin_username" {
  type        = string
  description = "The administrator username for the jumphost virtual machine."
}

variable "vnet_address_spaces" {
  type = object({
    vnet               = string
    default_subnet     = string
    app_subnet         = string
    integration_subnet = string
    admin_subnet       = string
    bastion_subnet     = string
  })
  default = {
    vnet               = "10.0.0.0/16"
    default_subnet     = "10.0.0.0/24"
    app_subnet         = "10.0.1.0/24"
    integration_subnet = "10.0.2.0/24"
    admin_subnet       = "10.0.3.0/24"
    bastion_subnet     = "10.0.4.0/24"
  }
  description = "The address prefixes for the vnet and it's subnets"
}
