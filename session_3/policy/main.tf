terraform {
  required_version = ">= 1.0.11"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.84.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "= 3.1.0"
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

#######################################################################################################
#Custom IL5 Policy
#######################################################################################################

locals {
  jsondata    = jsondecode(file("DOD_IL5_audit.json"))
  parameters  = local.jsondata.properties.parameters
  policy_list = local.jsondata.properties.policyDefinitions
}

resource "azurerm_policy_set_definition" "custom_dod_il5_initiative" {
  name                  = "${var.environment}-${var.policy_set_name}"
  policy_type           = var.policy_type
  display_name          = "${var.environment}-${var.policy_set_name}"
  description           = var.policy_description
  parameters            = jsonencode(local.parameters)

  metadata = <<METADATA
    {
    "category": "Regulatory Compliance",
    "version":  "19.0.0",
    "description": "Custom - This initiative includes policies that address a subset of DoD Impact Level 5 (IL5) controls. Additional policies will be added in upcoming releases. For more information, visit https://aka.ms/dodil5-initiative."
    }
  METADATA
  dynamic "policy_definition_reference" {
    for_each = local.policy_list

    content {
      policy_definition_id = policy_definition_reference.value["policyDefinitionId"]
      parameter_values     = try(length(policy_definition_reference.value["parameters"]) > 0, false) ? jsonencode(policy_definition_reference.value["parameters"]) : ""
      reference_id         = policy_definition_reference.value["policyDefinitionReferenceId"]
    }
  }
}

resource "azurerm_subscription_policy_assignment" "custom_dod_il5_assignment" {
  name                 = "${var.environment}-${var.policy_set_assignment_name}"
  display_name         = "${var.environment}-${var.policy_set_assignment_name}"
  policy_definition_id = azurerm_policy_set_definition.custom_dod_il5_initiative.id
  subscription_id      = var.subscription_id
  identity {
    type = "SystemAssigned"
  }
  location = "West US"
}
