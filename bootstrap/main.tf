resource "azurerm_resource_group" "rg" {
  name     = "rg-tfstate"
  location = "eastus"
}

resource "azurerm_storage_account" "sa" {
  name                     = "tfstate${random_integer.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Standard_LRS"
  kind                     = "StorageV2"
  enable_https_traffic_only = true
}

resource "azurerm_storage_container" "container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}
