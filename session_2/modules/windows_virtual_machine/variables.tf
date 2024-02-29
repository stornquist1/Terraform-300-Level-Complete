variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  type        = string
  default     = ""
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
  default     = ""
}

variable "key_vault_name" {
  description = "The name of the associated Key Vault."
  type        = string
  default     = ""
}

variable "key_vault_seed_string" {
  description = "Key Vault names must be Globally Unique. A seed string can be provided to help generate new unique names or to keep existing ones present. This is especially useful when the same key vault name is used across multiple configurations as the seed string's output is concatenated with the key vault name to generate a unique name"
  type        = string
  default     = ""
}

variable "key_vault_secret_name" {
  description = "The name of the secret in the key vault"
  type        = string
  default     = ""
}

variable "network_security_group_name" {
  description = "The name of the network security group"
  type        = string
  default     = ""
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "The name of the subnet to use in VM scale set"
  type        = string
  default     = ""
}

variable "public_ip_address_name" {
  description = "The name of the public IP address"
  type        = string
  default     = ""
}

variable "nic_name" {
  description = "The name of the Network Interface Card (NIC) to use in VM scale set"
  type        = string
  default     = ""
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  default     = ""
}

variable "admin_username" {
  description = "The username for the virtual machine"
  type        = string
  default     = ""
}

variable "disk_name" {
  description = "The name of the managed disk"
  type        = string
  default     = ""
}
