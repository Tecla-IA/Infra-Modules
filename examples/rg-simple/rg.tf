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
