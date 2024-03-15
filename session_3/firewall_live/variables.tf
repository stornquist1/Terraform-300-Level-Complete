variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
}

variable "vnet_name" {
    description = "Name of the virtual network"
    type        = string
}

variable "subnet_name" {
    description = "Name of the subnet"
    type        = string
}

variable "firewall_name" {
    description = "Name of the firewall"
    type        = string
}

variable "firewall_sku" {
    description = "SKU of the firewall"
    type        = string
}

variable "public_ip_name" {
    description = "Name of the public IP"
    type        = string
}

variable "app_rule_collection_name" {
    description = "Name of the application rule collection"
    type        = string
}

variable "network_rule_collection_name" {
    description = "Name of the network rule collection"
    type        = string
}

variable "firewall_sku_name" {
    description = "Name of the firewall SKU"
    type        = string
}

variable "firewall_sku_tier" {
    description = "Tier of the firewall SKU"
    type        = string
}