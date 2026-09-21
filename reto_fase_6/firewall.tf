resource "google_compute_firewall" "app_http" {
  name    = "${var.prefijo}-permitir-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.web_server_tag]
}

resource "google_compute_firewall" "ssh_iap" {
  name    = "${var.prefijo}-permitir-ssh-iap"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # 35.235.240.0/20 es el rango desde el que Google reenvía SSH
  # a través de IAP. Es el único origen autorizado para el 22.
  source_ranges = ["35.235.240.0/20"]
  target_tags   = [var.web_server_tag]
}

# Comunicación interna Web a Privada
resource "google_compute_firewall" "app_a_privada" {
  name    = "${var.prefijo}-permitir-app-a-privada"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_tags = [var.web_server_tag]
  target_tags = [var.private_server_tag]
}

# SSH seguro por túnel IAP a la máquina privada
resource "google_compute_firewall" "ssh_iap_privada" {
  name    = "${var.prefijo}-permitir-ssh-iap-privada"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = [var.private_server_tag]
}