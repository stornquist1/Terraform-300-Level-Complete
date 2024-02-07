############### Data Sources ###############

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to assign the firewall set to."
}

variable "firewall_subnet_name" {
  type        = string
  description = "The name of the firewall subnet."
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network."
}

############### Firewall ###############