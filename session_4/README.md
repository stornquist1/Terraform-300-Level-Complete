# Insert Answer Files Here

starting resource configuration:

# appservice.tf

resource "azurerm_service_plan" "app_service" {
name = var.app_service_name
resource_group_name = var.rg_name
location = data.azurerm_resource_group.tf_rg.location
os_type = var.app_service_os_type
sku_name = var.app_service_sku
}

# resource "azurerm_windows_web_app" "web_app" {

# name = var.app_name

# resource_group_name = azurerm_service_plan.app_service.resource_group_name

# location = azurerm_service_plan.app_service.location

# service_plan_id = azurerm_service_plan.app_service.id

# site_config {

# always_on = false

# }

# }

# database.tf

resource "azurerm_mssql_server" "example" {

# name = "my-sql-server-005"

# resource_group_name = data.azurerm_resource_group.tf_rg.name

# location = data.azurerm_resource_group.tf_rg.location

# version = "12.0"

# administrator_login = "adminuser"

# administrator_login_password = "P@ssw0rd123!"

# tags = {

# environment = "dev"

# }

# }

# resource "azurerm_mssql_database" "example" {

# name = "my-sql-database"

# server_id = azurerm_mssql_server.example.id

# # compute_model = "Serverless"

# # min_capacity = 0.5

# # max_capacity = 2

# # auto_pause_delay = 60

# tags = {

# environment = "dev"

# }

# }

Contoso has several resources already deployed in Azure but would like them to be managed through terraform.
terraform import cmd:
terraform import azurerm_service_plan.app_service

terraform import block:
import {
to = azurerm_mssql_server.example
id = ""
}

The alias name for the azure app service plan is not descriptive enough and is causing some confusion for Contoso's engineers. They would like you to rename the resource block for the azure app service
move command:
terraform state mv azurerm_service_plan.app_service azurerm_service_plan.app_service_plan
