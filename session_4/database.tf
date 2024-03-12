# resource "azurerm_mssql_server" "example" {
#     name                         = "my-sql-server-005"
#     resource_group_name          = data.azurerm_resource_group.tf_rg.name
#     location                     = data.azurerm_resource_group.tf_rg.location
#     version                      = "12.0"
#     administrator_login          = "adminuser"
#     administrator_login_password = "P@ssw0rd123!"

#     tags = {
#         environment = "dev"
#     }
# }

# resource "azurerm_mssql_database" "example" {
#     name                = "my-sql-database"
#     server_id         = azurerm_mssql_server.example.id
#     # compute_model       = "Serverless"
#     # min_capacity        = 0.5
#     # max_capacity        = 2
#     # auto_pause_delay     = 60

#     tags = {
#         environment = "dev"
#     }
# }