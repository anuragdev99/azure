variable "location" {
  type    = string
  default = "eastus"
}

variable "resource_group_name" {
  type    = string
  default = "rg-terraform-vm"
}

variable "vm_name" {
  type    = string
  default = "ubuntu-vm"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
  type        = string
  description = "Your SSH public key (passed via GitHub secret SSH_PUBLIC_KEY)"
}
