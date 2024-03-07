variable "rg_name" {
  type        = string
  description = "The resource group name"
}

variable "app_service_name" {
  type        = string
  description = "The app service name"
}

variable "app_service_os_type" {
  type        = string
  description = "The app service os type"
}

variable "app_service_sku" {
  type        = string
  description = "The app service sku"
}

variable "app_name" {
  type        = string
  description = "The function app name"
}

variable "app_settings" {
  type        = list(string)
  description = "A list of app setting names used to retrieve secrets from the key vault"
  default = ["CloudIntelEndpoint", "CloudIntelKey", "DBConnectionString"]
  
}