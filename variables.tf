# Variables

variable "proyecto"     { type = string }
variable "prefijo"      { type = string }
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