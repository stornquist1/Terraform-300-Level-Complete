terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.24.0"
    }
  }
}

provider "azurerm" {
  features {}
}
