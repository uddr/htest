provider "kubernetes" {
  version = ">= 1.10.0"
  cluster_ca_certificate  = var.cluster_ca_certificate
  host                    = var.host
  token                   = var.token
  load_config_file = false
}

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

resource "kubernetes_ingress" "basic-ingress" {
  metadata {
    name = "basic-ingress"
  }

  spec {
    backend {
      service_name = "prometheus-grafana"
      service_port = 80
    }
  }
}
