# 1. IP pública de la máquina de aplicación
output "ip_publica_app" {
  value       = google_compute_instance.app.network_interface[0].access_config[0].nat_ip
  description = "Dirección IP pública efímera del servidor web de aplicación"
}

# 2. IP interna de la máquina de aplicación
output "ip_interna_app" {
  value       = google_compute_instance.app.network_interface[0].network_ip
  description = "Dirección IP interna asignada por la subred pública"
}

# 3. IP interna de la máquina privada
output "ip_interna_privada" {
  value       = google_compute_instance.private_app.network_interface[0].network_ip
  description = "Dirección IP interna asignada por la subred privada de datos"
}

# 4. Comando SSH para conectar a la máquina pública vía IAP
output "ssh_app" {
  value       = "gcloud compute ssh ${google_compute_instance.app.name} --zone=${google_compute_instance.app.zone} --tunnel-through-iap"
  description = "Comando gcloud para acceder por SSH a la máquina pública por túnel IAP"
}

# 5. Comando SSH para conectar a la máquina privada vía IAP
output "ssh_privada" {
  value       = "gcloud compute ssh ${google_compute_instance.private_app.name} --zone=${google_compute_instance.private_app.zone} --tunnel-through-iap"
  description = "Comando gcloud para acceder por SSH a la máquina privada sin IP externa"
}

# Salidas complementarias
output "url_aplicacion" {
  value       = "http://${google_compute_instance.app.network_interface[0].access_config[0].nat_ip}"
  description = "Enlace directo para probar el servicio en el navegador"
}

output "subred_privada_id" {
  value       = google_compute_subnetwork.privada.id
  description = "Identificador de la subred privada de datos"
}