resource "azurerm_container_registry" "acr" {
  name                = "readinessacr"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  sku                 = "Standard"
}

resource "azurerm_role_assignment" "acr_to_aks_connector" {
  principal_id                     = azurerm_kubernetes_cluster.aks.identity.0.principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}