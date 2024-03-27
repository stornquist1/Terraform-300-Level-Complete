locals {
  suffix = "example1"
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${local.suffix}"
  location = "East US"
}

resource "azurerm_user_assigned_identity" "example" {
  name                = "id-${local.suffix}"
  location            = "East US"
  resource_group_name = azurerm_resource_group.example.name
}
