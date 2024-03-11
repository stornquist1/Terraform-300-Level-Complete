terraform {
  # # Use local backend for local development, use azurerm backend for Azure development / deployment
  # backend "local" {}
  backend "azurerm" {
    # environment          = "usgovernment"
    resource_group_name  = "rg-tf300session2"
    storage_account_name = "sastatetf300session2"
    container_name       = "fileshare-tf300session2"
    key                  = "tf300session2chioke.tfstate"
  }
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

  required_version = ">= 1.3.10"
}

provider "azurerm" {
  features {}
  # environment                = "usgovernment"
  skip_provider_registration = true
  storage_use_azuread        = true
}
