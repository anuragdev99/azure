variable "ssh_public_key" {
  type        = string
  description = "Public SSH key for the VM admin user"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "allowed_ip" {
  type        = string
  description = "Your laptop public IP in CIDR (e.g. 203.0.113.4/32)"
  default     = "0.0.0.0/0"
}
