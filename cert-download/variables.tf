variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "client_id" {
  description = "Federated OIDC App (client) ID"
  type        = string
}

variable "vm_id" {
  description = "Full resource ID of the target VM to extend"
  type        = string
}
