data "azurerm_storage_account" "account" {
  resource_group_name = var.resource_group_name
  name = var.storage_account_name
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = data.azurerm_storage_account.account.name
  container_access_type = var.container_access_type
}
