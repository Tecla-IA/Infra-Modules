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

module "rg_test" {
  source              = "../../modules/resource-groups"
  resource_group_name = "test-rg"
  location            = "East US"
  tags = {
    environment = "TEST"
    owner       = "Terraform"
  }
}

module "postgresql" {
  source                 = "../../modules/postgresql-db"
  server_name            = "test-pg-server"
  location               = "West US"
  resource_group_name    = module.rg_test.resource_group_name
  administrator_login    = "tecla"
  administrator_password = "tecla"
  postgresql_version     = "15"
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768
  default_db             = "test"


  tags = {
    environment = "TEST"
    owner       = "Terraform"
  }
}

output "postgresql_connection_string" {
  description = "Connection string to connect to the PostgreSQL database from pgAdmin."
  value = format("postgresql://%s:%s@%s:%d/%s",
    "tecla",
    "tecla",
    module.postgresql.postgresql_server_fqdn,
    5432,      // Default PostgreSQL port
    "postgres" // Using the default PostgreSQL database
  )
}
