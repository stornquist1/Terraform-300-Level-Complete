# Define the module
module "windows_vm" {
  source = "../"

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

# Output the virtual machine details
output "vm_details" {
  value = module.windows_vm.vm_details
}
