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