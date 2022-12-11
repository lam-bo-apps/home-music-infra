output "DATAFLOW_GITHUB_SERVICE_ACCOUNT" {
  value       = google_service_account.dataflow_github_actions.email
  description = "Service account to use in GitHub Action for federated auth in dataflow project"
}

output "DATAFLOW_GITHUB_IDENTITY_PROVIDER" {
  value       = google_iam_workload_identity_pool_provider.dataflow_github_actions.name
  description = "Provider ID to use in Auth action for GCP in GitHub for dataflow project"
}

output "DATAFLOW_REGISTRY_BASE_URL" {
  value       = "${var.region}-docker.pkg.dev"
  description = "Artifact Registry base url for dataflow tasks"
}

output "DATAFLOW_REGISTRY_IMAGE_PATH" {
  value       = "${data.google_project.project.project_id}/${google_artifact_registry_repository.dataflow.name}"
  description = "Artifact Registry path for dataflow tasks"
}


