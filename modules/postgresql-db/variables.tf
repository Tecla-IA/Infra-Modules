variable "server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "location" {
  description = "The Azure region where the PostgreSQL server will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "administrator_login" {
  description = "The administrator username for the PostgreSQL server."
  type        = string
}

variable "administrator_password" {
  description = "The administrator password for the PostgreSQL server."
  type        = string
  sensitive   = true
}

variable "postgresql_version" {
  description = "The version of PostgreSQL to use (e.g., '14')."
  type        = string
  default     = "15"
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL Flexible Server (e.g., 'Standard_D2s_v3')."
  type        = string
  default     = "B_Standard_B1ms"
}

variable "storage_mb" {
  description = "The storage size in MB for the server."
  type        = number
  default     = 32768
}

variable "backup_retention_days" {
  description = "The number of days to retain backups."
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable or disable geo-redundant backups."
  type        = bool
  default     = false
}

variable "start_ip_address" {
  description = "The starting IP address for the firewall rule."
  type        = string
  default     = "0.0.0.0"
}

variable "end_ip_address" {
  description = "The ending IP address for the firewall rule."
  type        = string
  default     = "0.0.0.0"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "high_availability_mode" {
  description = "(Optional) The high availability mode for the PostgreSQL server. Possible values are 'ZoneRedundant', 'SameZone', or empty string (no high availability). Defaults to empty string."
  type        = string
  default     = ""

  validation {
    condition     = var.high_availability_mode == "" || contains(["ZoneRedundant", "SameZone"], var.high_availability_mode)
    error_message = "Invalid high availability mode. Allowed values are 'ZoneRedundant', 'SameZone', or empty string."
  }
}

variable "zone" {
  description = "(Optional) The availability zone where the server will be deployed. Possible values: '1', '2', '3'."
  type        = string
  default     = null
}
