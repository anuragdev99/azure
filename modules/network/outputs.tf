output "rg_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "Resource group location"
  value       = azurerm_resource_group.rg.location
}
