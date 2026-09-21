# La VPC es global. En modo personalizado nace sin subredes.
resource "google_compute_network" "vpc" {
  name                    = "${var.prefijo}-vpc"
  auto_create_subnetworks = false
}



# La subred sí es regional, y es donde las máquinas toman su IP interna.
resource "google_compute_subnetwork" "publica" {
  name          = "${var.prefijo}-sub-publica"
  ip_cidr_range = var.cidr_publica
  region        = var.region
  network       = google_compute_network.vpc.id
}

# Red privada para el reto
resource "google_compute_subnetwork" "privada" {
  name          = "${var.prefijo}-sub-privada"
  ip_cidr_range = var.cidr_privada
  region        = var.region
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "app_http" {
  name    = "${var.prefijo}-permitir-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["practica-3-web-server-http"]
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
  target_tags   = ["practica-3-web-server-http"]
}
