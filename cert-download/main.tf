// cert-download/main.tf

// 1. Read the secret from Key Vault
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

  // Wrap the script in base64encode() and jsonencode()
  protected_settings = jsonencode({
    script = base64encode(<<-EOT
      #!/bin/bash
      set -e

      # Terraform has fetched the Base64-encoded secret value
      echo "${data.azurerm_key_vault_secret.cert.value}" \
        | base64 --decode > /tmp/my-cert.pfx

      chmod 600 /tmp/my-cert.pfx
    EOT
    )
  })
}
