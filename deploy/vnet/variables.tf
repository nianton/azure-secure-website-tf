variable "resource_group_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "location" {
  type        = string
  description = "(optional) describe your variable"
}

variable "tags" {
  description = "(optional) describe your variable"
}

variable "name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "include_bastion_host" {
  type    = bool
  default = true
}

variable "address_spaces" {
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
