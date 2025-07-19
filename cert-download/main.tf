resource "azurerm_virtual_machine_extension" "download_cert" {
  name                 = "cert-downloader"
  virtual_machine_id   = var.vm_id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  settings = jsonencode({
    commandToExecute = <<-CMD
      bash -c 'curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash \
      && az login --identity \
      && az keyvault secret download \
           --vault-name kv-vm-z4ahhe \
           --name my-cert \
           --file /tmp/my-cert.pfx \
           --encoding base64'
    CMD
  })
}
