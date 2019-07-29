variable "gce_ssh_user" {}
variable "gce_ssh_pub_key_file" {}

provider "google" {
  project = "vpc-sandbox"
  region  = "australia-southeast1"
  zone    = "australia-southeast1-a"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.subnetwork_1.name}"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
}

resource "google_compute_network" "vpc_network_1" {
  name                    = "network-1"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc_network_2" {
  name                    = "network-2"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork_1" {
  name   = "network-1-subnet-1"
  ip_cidr_range = "10.128.0.0/20"
  network       = "${google_compute_network.vpc_network_1.self_link}"
}

resource "google_compute_subnetwork" "subnetwork_2" {
  name   = "network-2-subnet-1"
  ip_cidr_range = "10.132.0.0/20"
  network       = "${google_compute_network.vpc_network_2.self_link}"
}

resource "google_compute_firewall" "firewall_network_1" {
  name    = "network-1-firewall"
  network = "${google_compute_network.vpc_network_1.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080"]
  }
}

resource "google_compute_firewall" "firewall_network_2" {
  name    = "network-2-firewall"
  network = "${google_compute_network.vpc_network_2.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080"]
  }
}
