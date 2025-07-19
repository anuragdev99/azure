resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-main"
  location            = var.location
  resource_group_name = var.rg_name


  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "ubuntu-vm"
  location                        = var.location
  resource_group_name             = var.rg_name
  size                            = "Standard_B1s"
  admin_username                  = "azureuser"
  network_interface_ids           = [azurerm_network_interface.nic.id]
  disable_password_authentication = true

  identity { type = "SystemAssigned" }

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "myosdisk"
  }

source_image_reference {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts-gen2"
  version   = "latest"
 }
}

/* resource "azurerm_virtual_machine_extension" "install_cert" {
  name                 = "install-cert"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  settings = <<SETTINGS
{
  "commandToExecute": "az login --identity && export CERT=$(az keyvault certificate list --vault-name kv-vm-${random_string.suffix.result} --query '[0].name' -o tsv) && az keyvault secret download --vault-name kv-vm-${random_string.suffix.result} --name \"$CERT\" --file /tmp/$CERT.pfx --encoding base64"
}
SETTINGS
}
*/

output "vm_public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "vm_object_id" {
  value = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}
