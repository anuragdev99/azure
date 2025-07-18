#!/bin/bash

# Log in using managed identity
az login --identity

# Get latest certificate name
CERT=$(az keyvault certificate list --vault-name "$1" --query '[0].name' -o tsv)

# Download the certificate as PFX
az keyvault certificate download --vault-name "$1" --name "$CERT" --file "/tmp/$CERT.pfx" --encoding Pkcs12
