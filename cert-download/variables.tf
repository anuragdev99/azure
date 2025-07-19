variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "client_id" {
  description = "Client ID used for OIDC authentication"
  type        = string
}

variable "vm_id" {
  description = "Resource ID of the VM"
  type        = string
}
