output "helm_service_account" {
  #value = "${kubernetes_service_account.tiller.metadata.0.name}"
  value = "default"
}

output "helm_namespace" {
  # value = "${kubernetes_service_account.tiller.metadata.0.namespace}"
  value = "kube-system"
}
