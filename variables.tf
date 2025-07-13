variable "location" {
  description = "Azure region to deploy into"
  type        = string
  default     = "eastus"
}

variable "ssh_public_key" {
  description = "SSH public key for VM login"
  type        = string
}
