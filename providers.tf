terraform {
  required_version = ">= 1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.35.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.4.0"
    }
  }
}

# Azurerm *must* include a features{} block
provider "azurerm" {
  features {}
}

# AzureAD can pick up ARM_TENANT_ID and ARM_CLIENT_ID automatically
provider "azuread" {}
