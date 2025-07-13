output "vm_public_ip" {
  description = "The public IP address assigned to the Ubuntu VM"
  value       = azurerm_public_ip.vm.ip_address
}

output "keyvault_uri" {
  description = "The URI of the Azure Key Vault"
  value       = azurerm_key_vault.vault.vault_uri
}
