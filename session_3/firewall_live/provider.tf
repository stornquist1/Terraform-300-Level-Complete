terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = ">= 2.0"
        }
    }

    backend "local" {
        path = "terraform.tfstate"
    }
}

provider "azurerm" {
    features {}
}