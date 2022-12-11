
# GCR registry
resource "google_artifact_registry_repository" "dataflow" {
  provider = google-beta
  project = var.project_id

  description = "Registry for music dataflow images"
  location = var.region
  repository_id = "dataflow"
  format = "DOCKER"
}

# Service account to be used for federated auth to connect to GCR
resource "google_service_account" "dataflow_github_actions" {
  account_id   = "dataflow-github-actions-user"
  display_name = "Service Account impersonated in GitHub Actions for dataflow project"
}

# Role binding to allow publisher to publish images
resource "google_artifact_registry_repository_iam_member" "dataflow_github_actions" {
  provider   = google-beta
  project    = var.project_id
  location   = var.region
  repository = google_artifact_registry_repository.dataflow.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.dataflow_github_actions.email}"
}

# Identiy pool for GitHub action based identity's access to Google Cloud resources
resource "google_iam_workload_identity_pool" "dataflow_github_actions" {
  provider                  = google-beta
  workload_identity_pool_id = "dataflow-github-actions-pool"
}

# Configuration for GitHub identiy provider
resource "google_iam_workload_identity_pool_provider" "dataflow_github_actions" {
  provider                           = google-beta
  workload_identity_pool_id          = google_iam_workload_identity_pool.dataflow_github_actions.workload_identity_pool_id
  workload_identity_pool_provider_id = "dataflow-github-actions-provider"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.aud"        = "assertion.aud"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri        = "https://token.actions.githubusercontent.com"
    allowed_audiences = []
  }
}

# IAM policy bindings to the service account resources created by GitHub identify
resource "google_service_account_iam_member" "dataflow_pool_impersonation" {
  provider           = google-beta
  service_account_id = google_service_account.dataflow_github_actions.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.dataflow_github_actions.name}/attribute.repository/${var.dataflow_git_repo}"
}