terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.106.1"
    }
  }
}

provider "azurerm" {
  features {}
}

# Generate a secure password for the PostgreSQL administrator
resource "random_password" "db_admin_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

module "rg_test" {
  source              = "../../modules/resource-groups"
  resource_group_name = "test-rg"
  location            = "eastus"
  tags = {
    environment = "TEST"
    owner       = "Terraform"
  }
}

# Create a PostgreSQL Flexible Server
module "postgresql" {
  source                 = "../../modules/postgresql-db"
  server_name            = "keycloak-db-server-test"
  location               = "West US"
  resource_group_name    = module.rg_test.resource_group_name
  administrator_login    = "tecla"
  administrator_password = "tecla"
  postgresql_version     = "15"
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768
  tags = {
    environment = "TEST"
    owner       = "Terraform"
  }
}

# Create databases for Keycloak
resource "azurerm_postgresql_flexible_server_database" "keycloak_db" {
  name      = "keycloakdb"
  server_id = module.postgresql.postgresql_server_id
  charset   = "UTF8"
}

module "linux_web_app_test" {
  source                = "../../modules/linux-web-app"
  resource_group_name   = module.rg_test.resource_group_name
  location              = "West US"
  app_service_plan_name = "tecla-test-app-service-plan"
  web_app_name          = "tecla-test-auth-app"
  sku_name              = "P1v3"

  container_image_name = "docker.io/santir/teclaia-keycloak"
  container_image_tag  = "0.0.12"
  # website_port         = "8080"
  app_command_line = "start --optimized --proxy-headers forwarded --http-enabled true --hostname https://tecla-test-auth-app.azurewebsites.net"

  environment_variables = {
    "KEYCLOAK_ADMIN"           = "admin"
    "KEYCLOAK_ADMIN_PASSWORD"  = "admin"
    "PROXY_ADDRESS_FORWARDING" = "true"
    "KC_HOSTNAME_STRICT"       = "false"
    "KC_HOSTNAME_STRICT_HTTPS" = "false"
    "KC_DB"                    = "postgres"
    "KC_DB_URL_HOST"           = module.postgresql.postgresql_server_fqdn
    "KC_DB_URL_PORT"           = "5432"
    "KC_DB_URL_DATABASE"       = azurerm_postgresql_flexible_server_database.keycloak_db.name
    "KC_DB_USERNAME"           = module.postgresql.postgresql_administrator_login
    "KC_DB_PASSWORD"           = "tecla"
    # "KC_DB_URL_PROPERTIES"     = "?sslmode=require"
  }

  tags = {
    environment = "TEST"
    part        = "WebApp"
    owner       = "Terraform"
  }

  depends_on = [module.rg_test]
}

output "web_app_hostname" {
  value = module.linux_web_app_test.web_app_default_hostname

}

output "postgresql_connection_string" {
  description = "Connection string to connect to the Keycloak PostgreSQL database from pgAdmin."
  value = format(
    "postgresql://%s:%s@%s:%d/%s",
    module.postgresql.postgresql_administrator_login,
    # random_password.db_admin_password.result,
    "tecla",
    module.postgresql.postgresql_server_fqdn,
    5432,
    azurerm_postgresql_flexible_server_database.keycloak_db.name
  )
  sensitive = true
}
