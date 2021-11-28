provider "google" {
  project = "pivotal-tower-332104"
  region = "asia-southeast1"
  zone = "asia-southeast1-a"
}

resource "google_compute_global_address" "default" {
  name = "global-appserver-ip"
  address = "34.117.42.9"
}

resource "google_compute_instance" "vm_instance" {
  name = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_global_address.default.address
    }
  }
}