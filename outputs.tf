output "vm_public_ip" {
  value = azurerm_linux_virtual_machine.ubuntu.public_ip_address
}

output "keyvault_uri" {
  value = azurerm_key_vault.vault.vault_uri
}
