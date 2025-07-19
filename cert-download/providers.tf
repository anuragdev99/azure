terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstate123tuffs"
    container_name       = "tfstate"
    key                  = "cert-download.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  use_oidc        = true
  client_id       = var.client_id
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}
