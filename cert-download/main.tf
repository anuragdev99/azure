# cert-download/main.tf

data "azurerm_key_vault_secret" "cert" {
  name         = "my-cert"
  key_vault_id = var.keyvault_id
}

resource "azurerm_virtual_machine_extension" "download_cert" {
  name                 = "cert-downloader"
  virtual_machine_id   = var.vm_id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  # Terraform expects a single string here, so jsonencode() it
  protected_settings = jsonencode({
    script = <<-EOT
      #!/bin/bash
      set -e
      echo "${data.azurerm_key_vault_secret.cert.value}" | base64 --decode > /tmp/my-cert.pfx
      chmod 600 /tmp/my-cert.pfx
    EOT
  })
}
