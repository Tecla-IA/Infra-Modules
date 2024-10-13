variable "redis_name" {
  description = "The name of the Redis Cache."
  type        = string
}

variable "location" {
  description = "The Azure region where the Redis Cache will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the Redis Cache ('Basic', 'Standard', 'Premium')."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = "Invalid SKU name. Allowed values are 'Basic', 'Standard', 'Premium'."
  }
}

variable "capacity" {
  description = <<-EOT
    The size of the Redis Cache instance. Valid values depend on the SKU:
    - For 'Basic' and 'Standard' SKU, valid values are 0, 1, 2, 3, 4, 5, 6 (representing cache sizes from 250 MB to 53 GB).
    - For 'Premium' SKU, valid values are 1, 2, 3, 4 (representing cache sizes from 6 GB to 53 GB).
  EOT
  type        = number
  default     = 0
}

variable "enable_non_ssl_port" {
  description = "Enable the non-SSL port (6379)."
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "The minimum TLS version to support ('1.0', '1.1', '1.2')."
  type        = string
  default     = "1.2"

  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "Invalid TLS version. Allowed values are '1.0', '1.1', '1.2'."
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "The ID of the Subnet where the Redis Cache should be deployed. This requires the Premium SKU."
  type        = string
  default     = null
}

variable "shard_count" {
  description = <<-EOT
    The number of shards to create on a Premium Cluster Cache. Valid values are 1 to 10.
    Only applicable for 'Premium' SKU.
  EOT
  type        = number
  default     = null
}

variable "patch_schedules" {
  description = "A list of patch schedules."
  type = list(object({
    day_of_week        = string
    start_hour_utc     = number
    maintenance_window = optional(string)
  }))
  default = []
}
