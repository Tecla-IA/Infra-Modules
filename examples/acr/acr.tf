
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

locals {
  resource_group_name = "example-rg"
  location            = "East US"
}
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.location
}

module "acr" {
  source              = "../../modules/container-registry"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "East US"
  acr_name            = "exampleacr"
  sku                 = "Standard"
  admin_enabled       = false

  tags = {
    environment = "TEST"
    owner       = "Terraform"
  }
}
