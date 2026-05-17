# 1. Tenant Dedicated GCP Service Account
resource "google_service_account" "tenant_sa" {
  account_id   = "sa-${var.tenant_name}"
  display_name = "Workload Identity Service Account for Tenant ${var.tenant_name}"
  project      = var.project_id
}

# 2. GCP Secret Manager Secret to store Database Credentials
resource "google_secret_manager_secret" "db_credentials" {
  secret_id = "tenant-${var.tenant_name}-credentials"
  project   = var.project_id

  replication {
    automatic = true
  }
}

# Store database credentials as JSON payload in Secret Manager
resource "google_secret_manager_secret_version" "db_credentials_val" {
  secret      = google_secret_manager_secret.db_credentials.id
  secret_data = jsonencode({
    username = "${var.tenant_name}-user"
    password = var.db_password
    database = "${var.tenant_name}-db"
  })
}

# 3. IAM Binding - Grant Tenant GCP SA Read Access to ONLY its dedicated Secret
resource "google_secret_manager_secret_iam_member" "secret_accessor" {
  project   = var.project_id
  secret_id = google_secret_manager_secret.db_credentials.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.tenant_sa.email}"
}

# 4. Workload Identity IAM Binding
# This grants the Kubernetes ServiceAccount in GKE permission to impersonate the GCP ServiceAccount
resource "google_service_account_iam_member" "workload_identity_binding" {
  service_account_id = google_service_account.tenant_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.tenant_name}/${var.tenant_name}-sa]"
}
