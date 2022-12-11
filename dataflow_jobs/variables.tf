

variable "project_id" {
  type        = string
  description = "The Google Cloud project id"
  default     = "lam-bo-home-music-v2"
}

variable "region" {
  type        = string
  description = "The default region used for resources created"
  default     = "us-central1"
}