

variable "project_id" {
  type        = string
  description = "The Google Cloud project id"
  default     = "lam-bo-home-music"
}

variable "zone" {
  type        = string
  description = "The default zone used for resources created"
  default     = "europe-west9-a"
}

variable "region" {
  type        = string
  description = "The default region used for resources created"
  default     = "europe-west9"
}

variable "dataflow_git_repo" {
  type        = string
  description = "The org/repo of the Github code repository for the dataflow tasks"
  default = "lam-bo-apps/home-music-dataflow"
}