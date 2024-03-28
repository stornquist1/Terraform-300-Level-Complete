resource "helm_release" "testapp" {
  name       = var.helm_deployment_name
  repository = "oci://${var.azure_container_registry}/helm"
  chart      = "terra300app"
}
