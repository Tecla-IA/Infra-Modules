resource "azurerm_redis_cache" "redis" {
  name                = var.redis_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  sku_name            = var.sku_name
  family              = var.sku_name == "Premium" ? "P" : "C"

  enable_non_ssl_port = var.enable_non_ssl_port
  minimum_tls_version = var.minimum_tls_version

  subnet_id   = var.sku_name == "Premium" ? var.subnet_id : null
  shard_count = var.sku_name == "Premium" ? var.shard_count : null

  tags = var.tags

  dynamic "patch_schedule" {
    for_each = var.patch_schedules
    content {
      day_of_week        = patch_schedule.value.day_of_week
      start_hour_utc     = patch_schedule.value.start_hour_utc
      maintenance_window = lookup(patch_schedule.value, "maintenance_window", null)
    }
  }
}
