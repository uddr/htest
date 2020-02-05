output "helm_service_account" {
  value = "user-htest-cluster"
}

output "helm_namespace" {
  value = "${kubernetes_service_account.tiller.metadata.0.namespace}"
}
