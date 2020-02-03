provider "kubernetes" {
  version = ">= 1.5.2"
  cluster_ca_certificate  = var.cluster_ca_certificate
  host                    = var.host
  token                   = var.token

  load_config_file = false
  #config_path = var.kubeconfig
}

#resource "kubernetes_service_account" "tiller" {
#  metadata {
#    name      = "tiller"
#    namespace = "kube-system"
#  }
#  
#  automount_service_account_token = true
#}

resource "kubernetes_cluster_role_binding" "user" {
  metadata {
    name = "provider-user-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind = "User"
    name = var.email_address
  }
}

# resource "kubernetes_cluster_role_binding" "tiller" {
#   metadata {
#     name = "tiller"
#   }
# 
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "cluster-admin"
#   }
# 
#   subject {
#     api_group = ""
#     kind      = "ServiceAccount"
#     name      = "tiller"
#     namespace = "kube-system"
#   }
# }
