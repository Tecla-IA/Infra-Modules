variable "resource_group_name" {
  description = "The name of the resource group in which the storage account is located."
  type        = string
}
variable "container_name" {
  description = "The name of the storage container"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "container_access_type" {
  description = "The access level of the container (private or blob)"
  type        = string
  default     = "blob"
}
