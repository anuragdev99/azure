// ──────────────────────────────────────────────────────────────────────────
// Resource Group, VNet & Subnet
// ──────────────────────────────────────────────────────────────────────────
resource "azurerm_resource_group" "main" {
  name     = "rg-ubuntu-vault"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-ubuntu"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-ubuntu"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

// ──────────────────────────────────────────────────────────────────────────
// Public IP
// ──────────────────────────────────────────────────────────────────────────
resource "azurerm_public_ip" "vm" {
  name                = "pip-ubuntu-vm"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  allocation_method = "Dynamic"
  sku               = "Basic"
}

// ──────────────────────────────────────────────────────────────────────────
// Network Security Group (SSH/HTTP/HTTPS from allowed_ip)
// ──────────────────────────────────────────────────────────────────────────
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-ubuntu-vm"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = var.allowed_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.allowed_ip
    destination_address_prefix = "*"
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Network Interface (Public IP + NSG attached inside ip_configuration)
// ──────────────────────────────────────────────────────────────────────────
resource "azurerm_network_interface" "nic" {
  name                = "nic-ubuntu"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id

    network_security_group_id     = azurerm_network_security_group.nsg.id
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Ubuntu VM (System-Assigned Identity + SSH Key)
// ──────────────────────────────────────────────────────────────────────────
resource "azurerm_linux_virtual_machine" "ubuntu" {
  name                  = "ubuntu-vm"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  size                  = "Standard_B2s"
  admin_username        = "anuragadmin"
  network_interface_ids = [azurerm_network_interface.nic.id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = "anuragadmin"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Key Vault accessible by the VM’s Managed Identity
// ──────────────────────────────────────────────────────────────────────────
resource "azurerm_key_vault" "vault" {
  name                = "kv-ubuntu-access"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_linux_virtual_machine.ubuntu.identity[0].principal_id

    secret_permissions = [
      "Get",
      "List",
    ]
  }
}
