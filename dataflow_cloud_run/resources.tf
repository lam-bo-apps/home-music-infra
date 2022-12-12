#Enable firestore by enabling app engine
resource "google_app_engine_application" "app" {
  project       = var.project_id
  location_id   = var.firestore_location
  database_type = "CLOUD_FIRESTORE"
}

# Service account to be used for federated auth to connect to GCR
resource "google_service_account" "dataflow_cloud_run" {
  account_id   = "dataflow-cloud-run-user"
  display_name = "Dataflow service account for Cloud Run"
}

# Roles binding to allow publisher to publish images
resource "google_project_iam_member" "dataflow_cloud_run" {
  for_each = toset([
    "roles/datastore.user",
    "roles/secretmanager.secretAccessor"
  ])
  role    = each.key
  member  = "serviceAccount:${google_service_account.dataflow_cloud_run.email}"
  project = var.project_id
}