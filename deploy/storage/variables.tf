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

variable "vnet_id" {
  type        = string
  description = "Virtual network id to create the private endpoint in & link the respective private DNS zone."
}

variable "subnet_id" {
  type        = string
  description = "The subnet id to create the private endpoint in."
}