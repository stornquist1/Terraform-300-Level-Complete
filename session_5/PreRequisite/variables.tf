variable "location" {
  description = "The location/region of the resource."
  default     = "USGov Virginia"
}

variable "cluster_principal_id" {
  description = "The principal id of the resource."
}

variable "tenant_id" {
  description = "The tenant id of the resource."
}

variable "environment" {
  description = "The environment of the resource."
  default     = "usgovernment"
}

variable "cluster_client_secret" {
  description = "The client secret of the resource."
  sensitive   = true
}

variable "subscription_id" {
  description = "The subscription id of the resource."
}

variable "principal_id" {
  description = "The principal id of the resource."
}

variable "client_secret" {
  description = "The client secret of the resource."
  sensitive   = true
}
