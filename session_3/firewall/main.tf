
################# DATA SOURCES #################

data "azurerm_resource_group" "firewall_rg" {
  name = var.resource_group_name
}
data "azurerm_virtual_network" "firewall_vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

################# RESOURCES #################

resource "azurerm_virtual_network" "firewall_vnet" {
  name                = var.firewall_virtual_network_name
  location            = azurerm_resource_group.firewall_rg.location
  resource_group_name = azurerm_resource_group.firewall_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "firewall_subnet" {
  name                 = var.firewall_subnet_name
  resource_group_name  = data.azurerm_resource_group.firewall_rg.name
  virtual_network_name = data.azurerm_virtual_network.firewall_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_public_ip" "firewall_pip" {
  name                = var.firewall_public_ip_name
  location            = data.azurerm_resource_group.firewall_rg.location
  resource_group_name = data.azurerm_resource_group.firewall_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  resource_group_name = data.azurerm_resource_group.firewall_rg.name
  location            = data.azurerm_resource_group.firewall_rg.location
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "firewall"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}

resource "azurerm_firewall_network_rule_collection" "deny_rdp" {
  name                = "deny-rdp"
  resource_group_name = data.azurerm_resource_group.firewall_rg.name
  azure_firewall_name = azurerm_firewall.firewall.name
  action              = "Deny"
  priority            = 100

  rule {
    name                  = "deny-rdp-rule"
    description           = "Deny RDP traffic"
    source_addresses      = ["*"]
    destination_addresses = ["*"] # Add a valid destination address or address range here
    destination_ports     = ["3389"]
    protocols             = ["TCP"]
  }
}

resource "azurerm_firewall_network_rule_collection" "deny_all" {
  name                = "deny-all"
  resource_group_name = data.azurerm_resource_group.firewall_rg.name
  azure_firewall_name = azurerm_firewall.firewall.name
  action              = "Deny"
  priority            = 101

  rule {
    name                  = "deny-all-rule"
    description           = "Deny all traffic"
    source_addresses      = ["*"]
    destination_addresses = ["*"]
    destination_ports     = ["*"]
    protocols             = ["Any"]
  }
}

# module "AVM_firewall" {
#   source                      = "github.com/Azure/terraform-azurerm-avm-res-network-azurefirewall.git"
  
#   name                        = var.firewall_name
#   location                    = data.azurerm_resource_group.firewall_rg.location
#   resource_group_name         = data.azurerm_resource_group.firewall_rg.name
#   firewall_sku_name           = var.firewall_sku_name
#   firewall_sku_tier           = var.firewall_sku_tier
# }