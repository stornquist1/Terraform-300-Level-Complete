resource "azurerm_container_registry" "acr" {
  provider            = azurerm.container
  name                = "readinessacr"
  resource_group_name = data.azurerm_resource_group.container_rg.name
  location            = data.azurerm_resource_group.container_rg.location
  sku                 = "Standard"
}


# Now I do this

# resource "azurerm_role_assignment" "acr_to_aks_connector" {
#   provider                         = azurerm.container
#   principal_id                     = azurerm_kubernetes_cluster.aks.identity.0.principal_id
#   role_definition_name             = "AcrPull"
#   scope                            = azurerm_container_registry.acr.id
#   skip_service_principal_aad_check = true
# }
