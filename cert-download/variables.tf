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
  default     = "/subscriptions/304f61b6-4359-4c2b-ac0b-5c1383e8fb79/resourceGroups/rg-vm-keyvault/providers/Microsoft.Compute/virtualMachines/ubuntu-vm"
}
