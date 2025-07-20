resource "azurerm_virtual_machine_extension" "download_cert" {
  name                 = "cert-downloader"
  virtual_machine_id   = var.vm_id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  protected_settings = jsonencode({
    script = base64encode(<<-EOT
    #!/bin/bash
    set -e

    # data.azurerm_key_vault_secret.cert.value is Base64 from Key Vault
    echo "${data.azurerm_key_vault_secret.cert.value}" \
      | base64 --decode > /tmp/my-cert.pfx

    chmod 600 /tmp/my-cert.pfx
    EOT
    )
  })
}
