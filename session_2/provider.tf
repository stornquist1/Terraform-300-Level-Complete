terraform {
  # # Use local backend for local development, use azurerm backend for Azure development / deployment
  backend "local" {}
  # backend "azurerm" {
  #   # environment          = "usgovernment"
  # }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.78.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.45.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }

  required_version = ">= 1.3.6"
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false       
    }
  }
  # environment                = "usgovernment"
  skip_provider_registration = true
  storage_use_azuread        = true
  
}
