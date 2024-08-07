output "container_name" {
  value = azurerm_storage_container.container.name
}

output "container_url" {
  value = azurerm_storage_container.container.id
}
