output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = module.vm.vm_public_ip
}

output "key_vault_name" {
  description = "Name of the created Key Vault"
  value       = module.keyvault.key_vault_name
}
