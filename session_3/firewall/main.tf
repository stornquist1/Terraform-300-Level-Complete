
################# DATA SOURCES #################

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.firewall_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

################# RESOURCES #################

resource "azurerm_firewall" "firewall" {
  name                = "firewall"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                 = "firewall"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
  threat_intel_mode = "Alert"
  sku {
    name = "AZFW_Hub"
    tier = "Standard"
  }
}