resource "azurerm_kubernetes_cluster" "aks" {
  name                = "tfready-aks"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "tfready-aks"

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
