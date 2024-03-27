terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }
  }
}

provider "helm" {
  kubernetes {
    #FIX change to user certificates
    config_path = "~/.kube/config"
  }
}
