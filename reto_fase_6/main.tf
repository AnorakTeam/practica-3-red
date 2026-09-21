resource "google_compute_instance" "app" {
  name         = "${var.prefijo}-app"
  machine_type = var.tipo_maquina
  zone         = var.zona
  tags         = [var.web_server_tag]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    # la máquina debe quedar en tu subred, no en la default
    subnetwork = google_compute_subnetwork.publica.id
    # un bloque vacío aquí otorga una IP pública efímera
    access_config {}
  }

  metadata_startup_script = templatefile("${path.module}/scripts/startup_public_machine.sh.tftpl", {
    ip_privada = google_compute_instance.private_app.network_interface[0].network_ip
  })
}

resource "google_compute_instance" "private_app" {
  name         = "${var.prefijo}-private-app"
  machine_type = var.tipo_maquina
  zone         = var.zona
  tags         = [var.private_server_tag]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    # la máquina debe quedar en tu subred, no en la default
    subnetwork = google_compute_subnetwork.privada.id
    # un bloque vacío aquí otorga una IP pública efímera
    # pero si no se declara, toncs no se crea ip
  }

  metadata_startup_script = file("${path.module}/scripts/startup_private_machine.sh")
}
