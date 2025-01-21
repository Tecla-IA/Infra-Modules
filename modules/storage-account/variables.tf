variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account"
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication type of the storage account"
  default     = "LRS"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}

variable "enable_static_website" {
  description = "If true, enable static website hosting on this storage account."
  type        = bool
  default     = false
}

variable "index_document" {
  description = "The default index document for the static website."
  type        = string
  default     = "index.html"
}

variable "error_404_document" {
  description = "The custom 404/error document for the static website."
  type        = string
  default     = "index.html"
}
