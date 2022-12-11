resource "google_cloud_run_v2_job" "log_spotify_user_top_tracks" {
  name     = "log-spotify-user-top-tracks"
  location = "us-central1"
  launch_stage = "BETA"

  template {
    template {
      containers {
        image = "us-central1-docker.pkg.dev/lam-bo-home-music-v2/dataflow/log-spotify-user-top-tracks-task:main"
      }
    }
  }
}