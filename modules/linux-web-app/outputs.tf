output "web_app_default_hostname" {
  value       = azurerm_linux_web_app.webapp.default_hostname
  description = "The default hostname of the main web app."
}

output "slot_hostnames" {
  value       = { for s in azurerm_linux_web_app_slot.slot : s.name => s.default_hostname }
  description = "A map of slot names to their default hostnames."
}
