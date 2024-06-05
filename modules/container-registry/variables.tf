variable "resource_group_name" {
  description = "The name of the resource group in which to create the container registry."
  type        = string
}

variable "location" {
  description = "The location where the container registry will be created."
  type        = string
}

variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry."
  type        = string
  default     = "Standard"
}
variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled for the registry."
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostics."
  type        = string
  default     = ""
}

variable "enable_diagnostics" {
  description = "Flag to enable diagnostics for the Azure Container Registry."
  type        = bool
  default     = false
}

variable "log_analytics_name" {
  description = "Name for the acr monitor settings"
  default     = "acr-diagnostics"
}
