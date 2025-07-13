variable "ssh_public_key" {
  type        = string
  description = "Public SSH key for the VM admin user"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}
