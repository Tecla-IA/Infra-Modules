variable "resource_group_name" {
  description = "The name of the resource group in which to create the linux web app."
  type        = string
}

variable "location" {
  description = "The location where the container registry will be created."
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service plan."
  type        = string
}


variable "web_app_name" {
  description = "The name of the Linux web app."
  type        = string
}

variable "node_version" {
  type        = string
  description = "Node.js version for the application stack"
  default     = "20-lts"
}


variable "sku_name" {
  type        = string
  description = "The SKU for the plan"
  default     = "P1v3"
}

variable "webdeploy_publish_basic_authentication_enabled" {
  description = "Enable or disable basic authentication for Web Deploy publishing."
  type        = bool
  default     = false
}


variable "root_domain" {
  description = "(Optional) The name of the custom hostname"
  type        = string
  default     = null
}

variable "www_domain" {
  description = "(Optional) The name of the www custom hostname"
  type        = string
  default     = null
}


variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}


variable "environment_variables" {
  type        = map(string)
  description = "(Optional) Environment variables for the Linux Web App"
  default     = {}
}

variable "slots" {
  type = map(object({
    app_settings = map(string)
    tags         = map(string) # Optional
  }))
  description = "(Optional) Map of slot configurations where each key is a slot name and value is a map of its settings, particularly app settings."
  default     = {}
}
