module "windows_vm1" {
  source = "./modules/windows_virtual_machine"

  # Input variables
  resource_group_name         = "rg-terraform-vm"
  location                    = "eastus"
  key_vault_name              = "kvterraformvm"
  key_vault_seed_string       = "terraform-vm-template"
  key_vault_secret_name       = "admin-password"
  network_security_group_name = "terraform-vm-nsg"
  virtual_network_name        = "terraform-vm-vnet"
  subnet_name                 = "terraform-vm-subnet"
  public_ip_address_name      = "terraform-vm-pip"
  nic_name                    = "terraform-vm-nic"
  vm_name                     = "terraform-vm"
  admin_username              = "adminuser"
  disk_name                   = "terraform-vm-disk"
}

module "windows_vm2" {
  source = "./modules/windows_virtual_machine"

  # Input variables
  resource_group_name         = "rg-terraform-vm"
  location                    = "eastus"
  key_vault_name              = "kvterraformvm2"
  key_vault_seed_string       = "terraform-vm-template"
  key_vault_secret_name       = "admin-password2"
  network_security_group_name = "terraform-vmw-nsg"
  virtual_network_name        = "terraform-vmw-vnet"
  subnet_name                 = "terraform-vmw-subnet"
  public_ip_address_name      = "terraform-vm2-pip"
  nic_name                    = "terraform-vm2-nic"
  vm_name                     = "terraform-vm2"
  admin_username              = "adminuser"
  disk_name                   = "terraform-vm2-disk"
}

module "windows_vm3" {
  source = "./modules/windows_virtual_machine"

  # Input variables
  resource_group_name         = "rg-terraform-vm"
  location                    = "eastus"
  key_vault_name              = "kvterraformvm3"
  key_vault_seed_string       = "terraform-vm-template"
  key_vault_secret_name       = "admin-password3"
  network_security_group_name = "terraform-vmw-nsg"
  virtual_network_name        = "terraform-vmw-vnet"
  subnet_name                 = "terraform-vmw-subnet"
  public_ip_address_name      = "terraform-vm3-pip"
  nic_name                    = "terraform-vm3-nic"
  vm_name                     = "terraform-vm3"
  admin_username              = "adminuser"
  disk_name                   = "terraform-vm3-disk"
}

module "windows_vm4" {
  source = "./modules/windows_virtual_machine"

  # Input variables
  resource_group_name         = "rg-terraform-vm2"
  location                    = "eastus"
  key_vault_name              = "kvterraformvm4"
  key_vault_seed_string       = "terraform-vm-template"
  key_vault_secret_name       = "admin-password4"
  network_security_group_name = "terraform-vmw-nsg"
  virtual_network_name        = "terraform-vmw-vnet"
  subnet_name                 = "terraform-vmw-subnet"
  public_ip_address_name      = "terraform-vm4-pip"
  nic_name                    = "terraform-vm4-nic"
  vm_name                     = "terraform-vm4"
  admin_username              = "adminuser"
  disk_name                   = "terraform-vm4-disk"
}

module "windows_vm5" {
  source = "./modules/windows_virtual_machine"

  # Input variables
  resource_group_name         = "rg-terraform-vm2"
  location                    = "eastus"
  key_vault_name              = "kvterraformvm5"
  key_vault_seed_string       = "terraform-vm-template"
  key_vault_secret_name       = "admin-password5"
  network_security_group_name = "terraform-vmw-nsg"
  virtual_network_name        = "terraform-vmw-vnet"
  subnet_name                 = "terraform-vmw-subnet"
  public_ip_address_name      = "terraform-vm5-pip"
  nic_name                    = "terraform-vm5-nic"
  vm_name                     = "terraform-vm5"
  admin_username              = "adminuser"
  disk_name                   = "terraform-vm5-disk"
}

