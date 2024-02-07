terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.24.0"
    }
  }

#   backend "azurerm" {
#     # subscription_id      = "[your subscription id]"
#     # resource_group_name  = "rg-tf300"
#     # storage_account_name = "sastatetf300"
#     # container_name       = "tfstate-tf300"
#     # key                  = "tf300session2.tfstate"
#   }
}

provider "azurerm" {
  features {}
}
