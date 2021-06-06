
variable "naming_convention_type" {
  type    = string
  default = "suffix"

  validation {
    condition     = can(regex("^(prefix|suffix)$", var.naming_convention_type))
    error_message = "Must be 'prefix' or 'suffix'."
  }
}

variable "appName" {
  type    = string
  default = "secweb"
}

variable "environment" {
  type = string
}

variable "location" {
  type    = string
  default = "westeurope"
}