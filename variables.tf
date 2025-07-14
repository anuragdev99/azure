variable "ssh_public_key" {
  description = "SSH public key for VM login"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID (for Key Vault)"
  type        = string
}
