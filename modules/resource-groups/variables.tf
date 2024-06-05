variable "resource_group_name" {
  description = "(Required) the name of the resource group to create"
}

variable "tags" {
  description = "(Required) tags for the deployment"
  type        = map(any)
}

variable "location" {
  description = "(Required) the location of the resource group to create"
}
