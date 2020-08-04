provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

data "google_compute_image" "k3s_image" {
  name = var.gcp_image
  project = var.gcp_project
}

data "external" "password" {
  depends_on = [google_compute_instance.default]
  program = ["./get-password.sh"]

  query = {
    server_ip = google_compute_address.static.address
  }
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "default" {
  name = "k3s-master-tf"
  machine_type = var.machine_type
  boot_disk {
    initialize_params {
      image = data.google_compute_image.k3s_image.self_link
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  metadata = {
    user-data = local_file.user-data.content
  }
}

resource "local_file" "user-data" {
    filename = "user-data.yaml"
    content  = templatefile("user-data.yaml.tmpl", 
      {
        github_user   = var.github_user
        k3os_password = var.k3os_password
        k3os_token    = var.k3os_token
      }
    )
}

resource "local_file" "k8s-config" {
    filename = "config"
    content  = templatefile("config.tmpl", 
      {
        server_ip = google_compute_address.static.address
        admin_password = data.external.password.result.password
      }
    )

    provisioner "local-exec" {
    command = "./config.sh"
    environment = {
      server_ip = google_compute_address.static.address
      admin_password = data.external.password.result.password
    }
  }
}