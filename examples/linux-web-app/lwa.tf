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
  location            = "eastus"
  tags = {
    environment = "TEST"
    owner       = "Terraform"
  }
}

module "linux_web_app_test" {
  source                                         = "../../modules/linux-web-app"
  resource_group_name                            = module.rg_test.resource_group_name
  location                                       = module.rg_test.location
  app_service_plan_name                          = "tecla-test-app-service-plan"
  web_app_name                                   = "tecla-test-web-app"
  node_version                                   = "20-lts"
  sku_name                                       = "P0v3"
  
  environment_variables = {
    "WEBSITE_RUN_FROM_PACKAGE" = 1
  }
  tags = {
    environment = "TEST"
    part        = "WebApp"
    owner       = "Terraform"
  }
  slots = {
    staging = {
      app_settings = {
        "NODE_ENV" = "testing"
      }
      tags = {
        environment = "TEST"
        part        = "StagingSlot"

        owner = "Terraform"
      }
    }
  }

  depends_on = [module.rg_test]
}

output "web_app_hostname" {
  value = module.linux_web_app_test.web_app_default_hostname
}

output "slot_hostnames" {
  value = module.linux_web_app_test.slot_hostnames
}
