resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  tags                = var.tags

}

resource "azurerm_monitor_diagnostic_setting" "acr_diagnostics" {
  count                      = var.enable_diagnostics ? 1 : 0
  name                       = var.log_analytics_name
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = toset(["ContainerRegistryLoginEvents", "ContainerRegistryRepositoryEvents"])
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = toset(["AllMetrics"])
    content {
      category = metric.value
    }
  }
  lifecycle {
    ignore_changes = [log_analytics_workspace_id]
  }
}

locals {
  enable_diagnostics = var.enable_diagnostics && var.log_analytics_workspace_id != ""
}

resource "null_resource" "validate_log_analytics_workspace_id" {
  count = local.enable_diagnostics ? 1 : 0
  provisioner "local-exec" {
    command = "echo 'Error: log_analytics_workspace_id is required when enable_diagnostics is true' && exit 1"
    when    = destroy
  }
  provisioner "local-exec" {
    command = "echo 'log_analytics_workspace_id is provided'"
    when    = create
  }
}
