############### Data Sources ###############

# variable "resource_group_name" {
#   type        = string
#   description = "The name of the resource group to assign the firewall set to."
# }

# variable "firewall_subnet_name" {
#   type        = string
#   description = "The name of the firewall subnet."
# }

# variable "virtual_network_name" {
#   type        = string
#   description = "The name of the virtual network."
# }

############### Firewall ###############

# Need to add Maps and objects 
# Need to add optional keyword
# Copilot example

variable "firewall_rg_name" {
  type        = string
  description = "The name of the resource group to assign the firewall set to."
}

variable "location" {
  type        = string
  description = "The location/region of the resource group."
}

variable "firewall_subnet_name" {
  type        = string
  description = "The name of the firewall subnet."
}

variable "firewall_virtual_network_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "firewall_name" {
  type        = string
  description = "The name of the firewall."
}

variable "firewall_public_ip_name" {
  type        = string
  description = "The name of the firewall public IP."
}



