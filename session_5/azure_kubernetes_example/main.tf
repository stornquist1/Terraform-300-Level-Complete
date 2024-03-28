terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.95.0"
    }
  }
}

provider "azurerm" {
  client_id                  = var.principal_id
  tenant_id                  = var.tenant_id
  client_secret              = var.client_secret
  subscription_id            = var.subscription_id
  environment                = var.environment
  skip_provider_registration = true

  features {}
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}

data "azurerm_kubernetes_cluster" "default" {
  name                = "readinessaks"
  resource_group_name = "aks-rg"
}

resource "kubernetes_namespace" "test" {
  metadata {
    name = "test"
  }
}

resource "helm_release" "testapp" {
  name       = var.helm_deployment_name
  repository = "oci://${var.azure_container_registry}/helm"
  chart      = "terra300app"
}
