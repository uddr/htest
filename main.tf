module "gke_cluster" {
  source = "./modules/gke"
  
  project_name = var.project_name
  region = var.region
  # config_file = var.config_file
  cluster_name = var.cluster_name
  machine_type = var.machine_type
  node_count = var.node_count
  kubernetes_version = var.kubernetes_version
  master_kubernetes_version = var.master_kubernetes_version
}

module "k8s" {
  source = "./modules/k8s"
  #kubeconfig = module.gke_cluster.kubeconfig
  token =  module.gke_cluster.token
  cluster_ca_certificate =  module.gke_cluster.cluster_ca_certificate
  host =  module.gke_cluster.host
  email_address = module.gke_cluster.email
}

provider "google" {
  scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",
    "https://www.googleapis.com/auth/userinfo.email",
  ]

  credentials = file(var.config_file)
}

resource "google_storage_bucket_object" "kubeconfig" {
  name   = "kubeconfig"
  source = module.gke_cluster.kubeconfig
  bucket = var.gcs_bucket
}

module "helm" {
  source = "./modules/helm"

  helm_service_account = module.k8s.helm_service_account
  helm_namespace = module.k8s.helm_namespace
  token = module.gke_cluster.token
  cluster_ca_certificate = module.gke_cluster.cluster_ca_certificate
  host =  module.gke_cluster.host
  kubeconfig = module.gke_cluster.kubeconfig
}
