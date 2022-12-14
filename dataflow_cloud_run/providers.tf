# Required terraform and GCP provider versions

terraform {
  required_version = ">= 1.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.45.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.45.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}