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
  # No auth blocks; Terraform will use the ARM_* env vars + ARM_USE_OIDC
}
