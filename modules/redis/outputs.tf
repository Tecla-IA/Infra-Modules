output "redis_id" {
  description = "The ID of the Redis Cache."
  value       = azurerm_redis_cache.redis.id
}

output "redis_host_name" {
  description = "The host name of the Redis Cache."
  value       = azurerm_redis_cache.redis.hostname
}

output "redis_port" {
  description = "The non-SSL port of the Redis Cache."
  value       = azurerm_redis_cache.redis.port
}

output "redis_ssl_port" {
  description = "The SSL port of the Redis Cache."
  value       = azurerm_redis_cache.redis.ssl_port
}

output "redis_primary_access_key" {
  description = "The primary access key for the Redis Cache."
  value       = azurerm_redis_cache.redis.primary_access_key
  sensitive   = true
}

output "redis_secondary_access_key" {
  description = "The secondary access key for the Redis Cache."
  value       = azurerm_redis_cache.redis.secondary_access_key
  sensitive   = true
}

output "redis_connection_string" {
  description = "The connection string to connect to the Redis Cache over SSL."
  value = format("%s:%d,password=%s,ssl=True,abortConnect=False",
    azurerm_redis_cache.redis.hostname,
    azurerm_redis_cache.redis.ssl_port,
    azurerm_redis_cache.redis.primary_access_key
  )
  sensitive = true
}
