provider "google" {
  project = "dark-garden-256113"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

#resource "google_compute_network" "vpc_network" {
#  name                    = "terraform-network"
#  auto_create_subnetworks = "true"
#}
#
#resource "google_compute_instance" "vm_instance" {
#  name         = "terraform-instance"
#  machine_type = "f1-micro"
#
#  boot_disk {
#    initialize_params {
#      image = "debian-cloud/debian-9"
#    }
#  }
#
#  network_interface {
#    network = google_compute_network.vpc_network.self_link
#    access_config {
#    }
#  }
#}
