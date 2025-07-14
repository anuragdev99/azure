output "vm_public_ip" {
  description = "Public IP address of the Ubuntu VM"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "key_vault_uri" {
  description = "URI of the provisioned Key Vault"
  value       = azurerm_key_vault.kv.vault_uri
}
