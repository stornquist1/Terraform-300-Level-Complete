
data "azurerm_resource_group" "rg" {
    name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
    name                 = var.subnet_name
    resource_group_name  = data.azurerm_resource_group.rg.name
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.0.0/24"]  
}

resource "azurerm_public_ip" "firewall" {
    name                = var.public_ip_name
    resource_group_name = data.azurerm_resource_group.rg.name
    location            = data.azurerm_resource_group.rg.location
    allocation_method   = "Static"
    sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
    name                = var.firewall_name
    resource_group_name = data.azurerm_resource_group.rg.name
    location            = data.azurerm_resource_group.rg.location
    sku_name            = var.firewall_sku_name
    sku_tier            = var.firewall_sku_tier

    ip_configuration {
        name                 = "FirewallIPConfig"
        subnet_id            = azurerm_subnet.subnet.id
        public_ip_address_id = azurerm_public_ip.firewall.id
    }
}

resource "azurerm_firewall_application_rule_collection" "app_rules" {
    name                = var.app_rule_collection_name
    resource_group_name = data.azurerm_resource_group.rg.name
    azure_firewall_name = azurerm_firewall.firewall.name

    priority = 100
    action   = "Allow"

    rule {
        name                     = "AllowHTTP"
        description              = "Allow HTTP traffic"
        source_addresses         = ["*"]

        # Add other rule properties here
    }
}

resource "azurerm_firewall_network_rule_collection" "network_rules" {
    name                = var.network_rule_collection_name
    resource_group_name = data.azurerm_resource_group.rg.name
    azure_firewall_name = azurerm_firewall.firewall.name

    priority = 200
    action   = "Deny"

    rule {
        name                     = "DenySSH"
        description              = "Deny SSH traffic"
        source_addresses         = ["*"]
        destination_ports        = ["22"]
        protocols                = ["TCP"]

        # Add other rule properties here
    }
}
