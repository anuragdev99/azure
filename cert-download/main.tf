data "azurerm_key_vault_secret" "cert" {
  name         = "my-cert"
  key_vault_id = var.keyvault_id
}

resource "azurerm_virtual_machine_extension" "download_cert" {
  name                       = "cert-downloader"
  virtual_machine_id         = var.vm_id
  publisher                  = "Microsoft.Azure.Extensions"
  type                       = "CustomScript"
  type_handler_version       = "2.1"

  protected_settings = {
    script = <<-EOT
      #!/bin/bash
      set -e
      # data.azurerm_key_vault_secret.cert.value is Base64-encoded by Key Vault
      echo "${data.azurerm_key_vault_secret.cert.value}" | base64 --decode > /tmp/my-cert.pfx
      chmod 600 /tmp/my-cert.pfx
    EOT
  }
}
