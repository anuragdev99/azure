variable "tenant_id" {
  description = "Azure Tenant ID for Key Vault"
  type        = string
}

variable "vm_object_id" {
  description = "Principal ID of the VM's identity"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Resource group location"
  type        = string
}
