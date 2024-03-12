resource "azurerm_kubernetes_cluster" "aks" {
  name                = "readinessaks"
  location            = data.azurerm_resource_group.cluster_rg.location
  resource_group_name = data.azurerm_resource_group.cluster_rg.name
  dns_prefix          = "readinessaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

}

resource "local_file" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.aks]
  content    = azurerm_kubernetes_cluster.aks.kube_config_raw
  filename   = "~/.kube/config"
}
