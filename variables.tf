variable "config_file" {
  type      = string
}
variable "gcs_bucket" {
  type      = string
  default   = "dark-garden-256113-tfstate"
}
variable "region" {
  type      = string
  default   = "europe-west1"
}
variable "project_name" {
  type      = string
  default   = "dark-garden-256113"
}
variable "cluster_name" {
  type      = string
  default   = "htest"
}
variable "machine_type" {
  type      = string
  default   = "n1-standard-1"
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
