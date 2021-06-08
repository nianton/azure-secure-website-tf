variable "name" {
    type = string
    description = "(optional) describe your variable"
}

variable "resource_group_name" {
    type = string
    description = "(optional) describe your variable"
}

variable "location" {
    type = string
    description = "(optional) describe your variable"
}

variable "tags" {
  description = "The tags to be applied to the resources created."
}

variable "subnet_id" {
    type = string
    description = "The subnet id to host the Application Gateway"
}