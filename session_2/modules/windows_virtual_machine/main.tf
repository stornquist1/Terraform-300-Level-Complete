data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Ensure the key vault name is unique and under 24 chars
# Note: This resource requires a minimum of at length at least 1
resource "random_string" "key_vault" {
  length  = 24 - length(var.key_vault_name)
  special = false
  lower   = true
  upper   = true
  numeric = true
  keepers = (var.key_vault_seed_string != null) ? {
    # Generate a new id each time we switch to a new seed string
    seed = var.key_vault_seed_string
    } : {
    seed = var.key_vault_name
  }
}

resource "azurerm_key_vault" "kv" {
  name                        = "${var.key_vault_name}${random_string.key_vault.result}"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false
  sku_name                    = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set",
    ]
  }

  ### Key Vault Restrictions
  # Length between 3 and 24 characters with only alphanumerics and hyphens.
  # Source: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules
  lifecycle {
    precondition {
      condition     = (length(var.key_vault_name) + length(random_string.key_vault.result)) > 2 && (length(var.key_vault_name) + length(random_string.key_vault.result)) < 25 && can(regex("^[a-zA-Z0-9\\-]+$", var.key_vault_name))
      error_message = "Key Vault name length must be between 3 and 24 characters with only alphanumerics and hyphens"
    }
  }
}

resource "azurerm_key_vault_secret" "kvadminpass" {
  name         = var.key_vault_secret_name
  value        = random_password.vmadminpass.result
  key_vault_id = azurerm_key_vault.kv.id
}

resource "random_password" "vmadminpass" {
  length  = 16
  special = true
  upper   = true
}

resource "azurerm_network_security_group" "nsgjit" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {
    name                       = "srjit"
    priority                   = 4095
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = azurerm_network_interface.nic-TerraformVM.private_ip_address
  }
}

resource "azurerm_subnet_network_security_group_association" "snsjit" {
  subnet_id                 = azurerm_subnet.snet-Terraform.id
  network_security_group_id = azurerm_network_security_group.nsgjit.id
}

resource "azurerm_virtual_network" "vnet-Terraform" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "snet-Terraform" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet-Terraform.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "ipterraformpip" {
  name                = var.public_ip_address_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic-TerraformVM" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "VM-IP-config"
    subnet_id                     = azurerm_subnet.snet-Terraform.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ipterraformpip.id
    primary                       = true
  }
}

resource "azurerm_windows_virtual_machine" "vmTerra" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B2ms"
  admin_username      = var.admin_username
  admin_password      = azurerm_key_vault_secret.kvadminpass.value
  network_interface_ids = [
    azurerm_network_interface.nic-TerraformVM.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_managed_disk" "vmdatadisk" {
  name                 = var.disk_name
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  managed_disk_id    = azurerm_managed_disk.vmdatadisk.id
  virtual_machine_id = azurerm_windows_virtual_machine.vmTerra.id
  lun                = "10"
  caching            = "ReadWrite"
}
