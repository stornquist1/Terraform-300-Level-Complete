##############################################################################
# Helm and Docker configuration
##############################################################################

variable "helm_deployment_name" {
  description = "Name for the Helm release."
  type        = string
  default     = "terra300"
}

variable "image_tag" {
  description = "Image tag for Orchestrator components."
  type        = string
  default     = "1.7.0"
}

variable "azure_container_registry" {
  description = "URL of the Azure Container registry where images and helm charts are stored."
  type        = string
  default     = "readinessacr.azurecr.us/testapp"
}
