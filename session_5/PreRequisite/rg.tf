data "azurerm_resource_group" "cluster_rg" {
  name = "aks-rg"
}

data "azurerm_resource_group" "container_rg" {
  provider = azurerm.container
  name     = "container-rg"
}
