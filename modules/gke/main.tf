resource "google_container_cluster" "primary" {
  name = "${var.cluster_name}-cluster"
  project = var.project_name
  initial_node_count       = 1
  remove_default_node_pool = true
  min_master_version = var.master_kubernetes_version
  location      = var.region

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/userinfo.email",
    ]
  }
}

resource "random_id" "np" {
  byte_length = 11
  prefix      = "${var.cluster_name}-"

  keepers = {
    machine_type = var.machine_type
  }
}

resource "google_container_node_pool" "cluster_nodes" {
  project    = var.project_name
  name       = random_id.np.dec
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count
  version    = var.kubernetes_version

  node_config {
    machine_type = var.machine_type
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "google_client_config" "default" {}
data "google_client_openid_userinfo" "me" {}

data "template_file" "kubeconfig" {
  template = file("${path.module}/template/kubeconfig.cert.tpl")

  vars = {
    cluster_name               = google_container_cluster.primary.name
    certificate_authority_data = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
    server                     = "https://${google_container_cluster.primary.endpoint}"
    client_cert                = google_container_cluster.primary.master_auth.0.client_certificate
    client_key                 = google_container_cluster.primary.master_auth.0.client_key
    token                      = data.google_client_config.default.access_token
  }
}

resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = "${path.module}/kubeconfig"
}
