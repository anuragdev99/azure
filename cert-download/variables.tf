variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "client_id" {
  description = "Client ID for OIDC"
  type        = string
}

variable "keyvault_id" {
  description = "Full resource ID of the Key Vault"
  type        = string
}

variable "vm_id" {
  description = "Full resource ID of the VM"
  type        = string
}
