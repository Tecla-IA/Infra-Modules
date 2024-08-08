output "storage_account_name" {
  description = "Returns the name of the storage account"
  value       = azurerm_storage_account.account.name
}

output "storage_account_key" {
  description = "Returns the storage account's key"
  sensitive   = true
  value       = azurerm_storage_account.account.primary_access_key
}
