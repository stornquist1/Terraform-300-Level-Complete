
################# DATA SOURCES #################

# data "azurerm_resource_group" "rg" {
#   name = var.resource_group_name
# }

# data "azurerm_subnet" "subnet" {
#   name                 = var.firewall_subnet_name
#   virtual_network_name = var.virtual_network_name
#   resource_group_name  = var.resource_group_name
# }

################# RESOURCES #################

resource "azurerm_resource_group" "firewall_rg" {
  name     = var.firewall_rg_name
  location = var.location
}

resource "azurerm_virtual_network" "firewall_vnet" {
  name                = var.firewall_virtual_network_name
  location            = azurerm_resource_group.firewall_rg.location
  resource_group_name = azurerm_resource_group.firewall_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "firewall_subnet" {
  name                 = var.firewall_subnet_name
  resource_group_name  = azurerm_resource_group.firewall_rg.name
  virtual_network_name = azurerm_virtual_network.firewall_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "firewall_pip" {
  name                = var.firewall_public_ip_name
  location            = azurerm_resource_group.firewall_rg.location
  resource_group_name = azurerm_resource_group.firewall_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  resource_group_name = azurerm_resource_group.firewall_rg.name
  location            = azurerm_resource_group.firewall_rg.location
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "firewall"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}

# module "AVM_virtual_machine" {
#   source = "github.com/Azure/terraform-azurerm-avm-res-compute-virtualmachine.git"

#   name = "avm-vm-001"
#   resource_group_name = azurerm_resource_group.firewall_rg.name
#   virtualmachine_sku_size = "Standard_B2ms"

#   depends_on = [azurerm_resource_group.firewall_rg]
# }