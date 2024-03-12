terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      configuration_aliases = [
        azurerm,
        azurerm.container,
      ]
      source  = "hashicorp/azurerm"
      version = ">=3.85.0"
    }
  }
}

provider "azurerm" {
  client_id                  = var.cluster_principal_id
  tenant_id                  = var.tenant_id
  client_secret              = var.cluster_client_secret
  subscription_id            = var.subscription_id
  environment                = var.environment
  skip_provider_registration = true

  features {}
}

provider "azurerm" {
  alias = "container"

  client_id                  = var.principal_id
  tenant_id                  = var.tenant_id
  client_secret              = var.client_secret
  subscription_id            = var.subscription_id
  environment                = var.environment
  skip_provider_registration = true

  features {}
}
