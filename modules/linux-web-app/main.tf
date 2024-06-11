data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}
resource "azurerm_service_plan" "app_plan" {
  name                = var.app_service_plan_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku_name = var.sku_name
  os_type  = "Linux"
  tags     = var.tags
}

resource "azurerm_linux_web_app" "webapp" {
  name                = var.web_app_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_plan.id

  app_settings = var.environment_variables

  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled

  site_config {
    always_on  = true
    ftps_state = "Disabled"


    application_stack {
      node_version = var.node_version
    }
  }
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags

}

resource "azurerm_linux_web_app_slot" "slot" {
  for_each       = var.slots
  name           = "${each.key}"
  app_service_id = azurerm_linux_web_app.webapp.id
  app_settings   = each.value.app_settings
  tags           = merge(var.tags, each.value.tags != null ? each.value.tags : {})

  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
  site_config {
    always_on = true
    application_stack {
      node_version = var.node_version
    }
  }
}
