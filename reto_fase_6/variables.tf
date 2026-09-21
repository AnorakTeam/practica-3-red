# Variables

variable "proyecto"     { type = string }
variable "prefijo"      { type = string }

variable "image" {
    type = string
    default = "debian-cloud/debian-12"
}

variable "tipo_maquina" { 
    type = string
    default = "e2-micro"
}

variable "zona" {
    type = string
    default = "us-central1-a"
}

variable "region"       { 
    type = string  
    default = "us-central1" 
}
variable "cidr_publica" { 
    type = string  
    default = "10.10.1.0/24" 
}
variable "cidr_privada" {
    type = string
    default = "10.10.2.0/24"
}

variable "web_server_tag" {
    type = string
    default = "practica-3-web-server-http"
}

variable "private_server_tag" {
    type = string
    default = "practica-3-private-server"
}