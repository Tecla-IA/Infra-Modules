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
  location            = "West US"
  tags = {
    environment = "TEST"
    owner       = "Terraform"
  }
}

module "redis" {
  source              = "../../modules/redis"
  redis_name          = "tecla-redis-cache-test"
  location            = "West US"
  resource_group_name = module.rg_test.resource_group_name
  sku_name            = "Standard" # Ensures high availability
  capacity            = 0          # Smallest capacity for cost efficiency
  enable_non_ssl_port = true

  tags = {
    environment = "TEST"
    owner       = "Terraform"
  }
}

output "redis_connection_string" {
  description = "Connection string to connect to the Redis Cache."
  value = format("%s:%d,password=%s,ssl=True,abortConnect=False",
    module.redis.redis_host_name,
    module.redis.redis_ssl_port,
    module.redis.redis_primary_access_key
  )
  sensitive = true
}
