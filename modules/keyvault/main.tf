resource "azurerm_key_vault" "kv" {
  name                        = "kv-vm-${random_string.suffix.result}"
  location                    = var.location
  resource_group_name         = var.rg_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
 # soft_delete_enabled         = true
  purge_protection_enabled    = false

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.vm_object_id
    secret_permissions = ["Get", "List"]
    certificate_permissions = ["Get", "List"]
  }
}

output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}
