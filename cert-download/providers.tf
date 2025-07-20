terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.67.0"
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
  # no auth blocks here—Terraform will draw from ARM_* + ARM_USE_OIDC
}
