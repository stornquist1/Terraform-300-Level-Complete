# Folllow the Ingress Controller in AKS tutorial [here](https://github.com/MicrosoftDocs/azure-docs/blob/90f41730b9836e89d3e53b44707109c32b5e52d0/articles/aks/ingress-basic.md)

### [Cooler example with helm, K8s, and AzureRM here](https://github.com/hashicorp/terraform-provider-kubernetes/tree/main/_examples/aks)

## Step 1: Create an AKS resource

### NOTE: This example provisions a basic Managed Kubernetes Cluster. Other examples of the azurerm_kubernetes_cluster resource can be found in the [./examples/kubernetes directory within the GitHub Repository.](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/kubernetes).

Update the block below based on your environment.

Due to the fast-moving nature of AKS, we recommend using the latest version of the Azure Provider when using AKS and always reference the latest documentation.

[reference doc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster)

```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
    <!-- helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    } -->
  }
}

provider "azurerm" {
  features {}

  subscription_id   = "<azure_subscription_id>"
  tenant_id         = "<azure_subscription_tenant_id>"
  client_id         = "<service_principal_appid>"
  client_secret     = "<service_principal_password>"
}

data "azurerm_kubernetes_cluster" "default" {
  depends_on          = [module.aks-cluster] # refresh cluster state before reading
  name                = local.cluster_name
  resource_group_name = local.cluster_name
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
}

<!-- provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
} -->

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
  tags = {
    Environment = "terraform-300"
  }
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "terraform-300"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}
```

## Step 2: Connect to the cluster

```
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"

az aks get-credentials --resource-group <myResourceGroup> --name <myAKSCluster>

kubectl get nodes

kubectl --namespace ingress-basic get services -o wide -w nginx-ingress-ingress-nginx-controller
```

## Step 3: Use Helm to deploy an NGINX ingress Controller

```
# Create a namespace for your ingress resources
kubectl create namespace ingress-basic

# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Use Helm to deploy an NGINX ingress controller
helm install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace ingress-basic \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set controller.admissionWebhooks.patch.nodeSelector."beta\.kubernetes\.io/os"=linux
```

## Step 4: Use Kubernetes Provider to deploy an applicaition

always use [reference documenttation](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)

```
resource "kubernetes_deployment" "example1" {
  metadata {
    name = "aks-helloworld-one"
  }
  spec {
    replicas = 1
    selector {
      matchLabels = {
        app = "aks-helloworld-one"
      }
    }
    template {
      metadata = {
        labels = {
          app = "aks-helloworld-one"
        }
      }

      spec {
        container {
          name  = "aks-helloworld-one"
          image = "mcr.microsoft.com/azuredocs/aks-helloworld:v1"
          ports {
            containerPort = 80
          }
          env {
            name  = "TITLE"
            value = "Welcome to Azure Kubernetes Service (AKS)"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "example1" {
  metadata {
    name = "aks-helloworld-one"
  }

  spec {
    type = "ClusterIP"
    ports {
      port = 80
    }

    selector = {
      app = "aks-helloworld-one"
    }
  }
}
```

```
resource "kubernetes_deployment" "example2" {
  metadata {
    name = "aks-helloworld-two"
  }
  spec {
    replicas = 1
    selector {
      matchLabels = {
        app = "aks-helloworld-two"
      }
    }
    template {
      metadata = {
        labels = {
          app = "aks-helloworld-two"
        }
      }

      spec {
        container {
          name  = "aks-helloworld-two"
          image = "mcr.microsoft.com/azuredocs/aks-helloworld:v1"
          ports {
            containerPort = 80
          }
          env {
            name  = "TITLE"
            value = "AKS Ingress Demo"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "example2" {
  metadata {
    name = "aks-helloworld-two"
  }

  spec {
    type = "ClusterIP"
    ports {
      port = 80
    }

    selector = {
      app = "aks-helloworld-two"
    }
  }
}
```

## Step 5: Create An Ingress Route

### This is in YAML: Optional, convert to Terraform HCL

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-world-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
  - http:
      paths:
      - path: /hello-world-one(/|$)(.*)
        pathType: Prefix
        backend:
          service:
            name: aks-helloworld-one
            port:
              number: 80
      - path: /hello-world-two(/|$)(.*)
        pathType: Prefix
        backend:
          service:
            name: aks-helloworld-two
            port:
              number: 80
      - path: /(.*)
        pathType: Prefix
        backend:
          service:
            name: aks-helloworld-one
            port:
              number: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-world-ingress-static
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/rewrite-target: /static/$2
spec:
  rules:
  - http:
      paths:
      - path:
        pathType: Prefix
        backend:
          service:
            name: aks-helloworld-one
            port:
              number: 80
        path: /static(/|$)(.*)
```
