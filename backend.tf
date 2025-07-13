terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstate123tuffs"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
