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
    app_command_line = var.app_command_line


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
  name           = each.key
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

resource "azurerm_app_service_custom_hostname_binding" "root_hostname" {
  count               = var.root_domain != null ? 1 : 0
  hostname            = var.root_domain
  app_service_name    = azurerm_linux_web_app.webapp.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_app_service_custom_hostname_binding" "www_hostname" {
  count               = var.www_domain != null ? 1 : 0
  hostname            = var.www_domain
  app_service_name    = azurerm_linux_web_app.webapp.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_app_service_certificate_binding" "root_certificate_binding" {
  count               = var.root_domain != null ? 1 : 0
  certificate_id      = azurerm_app_service_managed_certificate.root_ssl[0].id
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.root_hostname[0].id
  ssl_state           = "SniEnabled"
}

resource "azurerm_app_service_certificate_binding" "www_certificate_binding" {
  count               = var.www_domain != null ? 1 : 0
  certificate_id      = azurerm_app_service_managed_certificate.www_ssl[0].id
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.www_hostname[0].id
  ssl_state           = "SniEnabled"
}

resource "azurerm_app_service_managed_certificate" "root_ssl" {
  count                      = var.root_domain != null ? 1 : 0
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.root_hostname[0].id
}

resource "azurerm_app_service_managed_certificate" "www_ssl" {
  count                      = var.www_domain != null ? 1 : 0
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.www_hostname[0].id
}
