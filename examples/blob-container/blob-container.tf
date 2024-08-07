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

module "storage_account" {
  source               = "../../modules/storage-account"
  resource_group_name  = module.rg_test.resource_group_name
  storage_account_name = "tfstoragetecla"

  tags = {
    environment = "TEST"
    owner       = "Terraform"
  }

  depends_on = [module.rg_test]
}

module "blob_container" {
  source               = "../../modules/blob-container"
  resource_group_name  = module.rg_test.resource_group_name
  storage_account_name = module.storage_account.storage_account_name
  container_name                 = "test-images"

  depends_on = [module.storage_account]
}
