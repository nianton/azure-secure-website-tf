variable "name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "resource_group_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "location" {
  type        = string
  description = "(optional) describe your variable"
}

variable "tags" {
  description = "The tags to be applied to the resources created."
}

variable "subnet_id" {
  type        = string
  description = "The subnet id to host the Application Gateway"
}

variable "domain_name_label" {
  type        = string
  description = "The Domain Name label to use for the public IP of the App GW"
}

variable "webapp_fqdn" {
  type        = string
  description = "The FQDN for the web app acting as the backend."
}
