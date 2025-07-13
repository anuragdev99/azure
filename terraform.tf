terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstate123tuffs"
    container_name       = "tfstate"
    key                  = "ubuntu-vm-keyvault.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "- ≥ 3.64.0"
    }
  }
}

provider "azurerm" {
  features {}
}
