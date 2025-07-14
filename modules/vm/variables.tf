variable "ssh_public_key" {
  description = "SSH public key for VM login"
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
