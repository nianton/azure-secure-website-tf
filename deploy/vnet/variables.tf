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
