variable "config_file" {
  type      = string
}
variable "k8s_bucket" {
  type      = string
}
variable "region" {
  type      = string
  default   = "europe-west1"
}
variable "project_name" {
  type      = string
}
variable "cluster_name" {
  type      = string
  default   = "htest"
}
variable "machine_type" {
  type      = string
  default   = "n1-standard-2"
}
variable "node_count" {
  type      = number
  default   = 1
}
variable "kubernetes_version" {
  type      = string
  default   = "1.13.11-gke.23"
}
variable "master_kubernetes_version" {
  type      = string
  default   = "1.13.11-gke.23"
}
