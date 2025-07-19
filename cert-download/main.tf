resource "azurerm_virtual_machine_extension" "install_cert" {
  name                 = "install-cert"
  virtual_machine_id   = "/subscriptions/304f61b6-4359-4c2b-ac0b-5c1383e8fb79/resourceGroups/rg-vm-keyvault/providers/Microsoft.Compute/virtualMachines/ubuntu-vm"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  settings = jsonencode({
    commandToExecute = "bash -c 'curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash && az login --identity --allow-no-subscriptions && az keyvault secret download --vault-name kv-vm-z4ahhe --name my-cert --file /tmp/my-cert.pfx --encoding base64'"
  })
}
