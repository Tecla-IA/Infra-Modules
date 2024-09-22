output "postgresql_server_id" {
  description = "The ID of the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.postgresql_server.id
}

output "postgresql_default_db" {
  description = "The database created with the module"
  value       = var.default_db
}

output "postgresql_server_fqdn" {
  description = "The FQDN of the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.postgresql_server.fqdn
}

output "postgresql_administrator_login" {
  description = "The administrator login name for the PostgreSQL server."
  value       = azurerm_postgresql_flexible_server.postgresql_server.administrator_login
}

output "postgresql_connection_string" {
  description = "Connection string to connect to the PostgreSQL database."
  value = format("postgresql://%s@%s:%d/%s",
    azurerm_postgresql_flexible_server.postgresql_server.administrator_login,
    azurerm_postgresql_flexible_server.postgresql_server.fqdn,
    5432,
    "postgres"
  )
}

output "postgresql_connection_string_with_password" {
  description = "Connection string including the password."
  value = format("postgresql://%s:%s@%s:%d/%s",
    azurerm_postgresql_flexible_server.postgresql_server.administrator_login,
    var.administrator_password,
    azurerm_postgresql_flexible_server.postgresql_server.fqdn,
    5432,
    "postgres"
  )
  sensitive = true
}
