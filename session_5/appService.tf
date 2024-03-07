resource "azurerm_service_plan" "app_service" {
  name                = var.app_service_name
  resource_group_name = var.rg_name
  location            = data.azurerm_resource_group.tf_rg.location
  os_type             = var.app_service_os_type
  sku_name            = var.app_service_sku
}

# resource "azurerm_windows_web_app" "web_app" {
#   name                = var.app_name
#   resource_group_name = azurerm_service_plan.app_service.resource_group_name
#   location            = azurerm_service_plan.app_service.location
#   service_plan_id     = azurerm_service_plan.app_service.id


#   site_config {
#     always_on = false
#   }
# }