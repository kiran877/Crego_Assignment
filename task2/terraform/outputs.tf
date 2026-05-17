output "gcp_service_account_email" {
  description = "The email of the tenant dedicated GCP service account"
  value       = google_service_account.tenant_sa.email
}

output "secret_id" {
  description = "The ID of the Secret Manager secret holding credentials"
  value       = google_secret_manager_secret.db_credentials.id
}
