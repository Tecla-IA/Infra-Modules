resource "azurerm_postgresql_flexible_server" "postgresql_server" {
  name                   = var.server_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  version                = var.postgresql_version

  sku_name   = var.sku_name
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  # Specify the availability zone
  zone = var.zone

  dynamic "high_availability" {
    for_each = var.high_availability_mode != "" ? [1] : []
    content {
      mode = var.high_availability_mode
    }
  }
  tags = var.tags
}


resource "azurerm_postgresql_flexible_server_database" "default_db" {
  name      = var.default_db
  server_id = azurerm_postgresql_flexible_server.postgresql_server.id
  charset   = "UTF8"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_access" {
  name      = "AllowAccess"
  server_id = azurerm_postgresql_flexible_server.postgresql_server.id

  start_ip_address = var.start_ip_address
  end_ip_address   = var.end_ip_address
}
