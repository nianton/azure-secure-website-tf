variable "name" {
  type        = string
  description = "name of"
}

variable "asp_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "appins_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "tags" {
}

variable "location" {

}

variable "use_managed_identity" {
  type        = bool
  default     = true
  description = "(optional) describe your variable"
}

variable "resource_group_name" {

}

variable "app_settings" {

}

variable "sku_name" {
  type        = string
  description = "The App Service Plan SKU name"
  default     = "P1v3"
  validation {
    condition     = can(regex("^(S1|S2|S3|P1v3|P2v3|P3v3)$", var.sku_name))
    error_message = "Allow values are: xxxxx."
  }
}