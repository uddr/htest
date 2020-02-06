provider "helm" {
  version = "0.10.4"
  service_account = var.helm_service_account
  namespace       = var.helm_namespace
  install_tiller  = false
  debug           = true

  kubernetes {
    cluster_ca_certificate  = var.cluster_ca_certificate
    host                    = var.host
    token                   = var.token
    config_path             = var.kubeconfig
  }
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "null_resource" "prometheus_operator" {
  provisioner "local-exec" {
    command = "helm --kubeconfig=modules/gke/kubeconfig install -f modules/helm/monitoring/prometheus/values.yml prometheus stable/prometheus-operator"
  }
  depends_on = [var.depends_on_gke_np]
}

resource "null_resource" "vault-helm" {
  provisioner "local-exec" {
    command = "helm --kubeconfig=modules/gke/kubeconfig install vault ../vault-helm"
  }
  depends_on = [var.depends_on_gke_np]
}

#resource "helm_release" "prometheus_operator" {
#  name       = "prometheus-operator"
#  repository = data.helm_repository.stable.metadata[0].name
#  chart      = "prometheus-operator"
#  namespace  = "default"
#
#  provisioner "local-exec" {
#    command = "helm --kubeconfig=modules/gke/kubeconfig install prometheus stable/prometheus-operator"
#  }
#  
#  values = [
#    file("${path.module}/monitoring/prometheus/values.yml"),
#  ]
#  depends_on = [var.depends_on_gke_np]
#}
#
#resource "helm_release" "vault-helm" {
#  name       = "vault"
#  chart      = "stable/vault-helm"
#  namespace  = "default"
#
#  depends_on = [var.depends_on_gke_np]
#
#  provisioner "local-exec" {
#    command = "helm --kubeconfig=modules/gke/kubeconfig install vault ../vault-helm"
#  }
#}
