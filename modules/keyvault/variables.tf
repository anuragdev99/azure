variable "tenant_id" {
  description = "Azure Tenant ID for Key Vault"
  type        = string
}

variable "vm_object_id" {
  description = "Principal ID of the VM's system‑assigned identity"
  type        = string
}
