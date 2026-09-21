terraform {
  required_providers {
    google = { source = "hashicorp/google" }
  }
}

provider "google" {
  project = var.proyecto
  region  = var.region
}