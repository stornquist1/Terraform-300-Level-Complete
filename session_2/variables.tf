variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = "rg-terraform-vm"
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = "eastus"
}

variable "key_vault_name" {
  description = "The name of the associated Key Vault."
  default     = "kvterraformvm"
}

variable "key_vault_seed_string" {
  description = "Key Vault names must be Globally Unique. A seed string can be provided to help generate new unique names or to keep existing ones present. This is especially useful when the same key vault name is used across multiple configurations as the seed string's output is concatenated with the key vault name to generate a unique name"
  default     = "terraform-vm-template"
}

variable "key_vault_secret_name" {
  description = "The name of the secret in the key vault"
  default     = "admin-password"
}

variable "network_security_group_name" {
  description = "The name of the network security group"
  default     = "terraform-vm-nsg"
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  default     = "terraform-vm-vnet"
}

variable "subnet_name" {
  description = "The name of the subnet to use in VM scale set"
  default     = "terraform-vm-subnet"
}

variable "public_ip_address_name" {
  description = "The name of the public IP address"
  default     = "terraform-vm-pip"
}

variable "nic_name" {
  description = "The name of the Network Interface Card (NIC) to use in VM scale set"
  default     = "terraform-vm-nic"
}

variable "vm_name" {
  description = "The name of the virtual machine"
  default     = "terraform-vm"
}

variable "admin_username" {
  description = "The username for the virtual machine"
  default     = "adminuser"
}

variable "disk_name" {
  description = "The name of the managed disk"
  default     = "terraform-vm-disk"
}
