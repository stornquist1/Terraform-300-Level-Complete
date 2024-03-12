terraform {
  backend "local" {}
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.95.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.7.2"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "1.2.21"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}