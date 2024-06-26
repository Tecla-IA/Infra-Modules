output "resource_group_name" {
  description = "Returns the name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "Returns the name of the resource location"
  value       = azurerm_resource_group.rg.location
}

