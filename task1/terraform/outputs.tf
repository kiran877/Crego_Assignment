output "db_name" {
  value = google_sql_database.tenant_db.name
}

output "db_user" {
  value = google_sql_user.tenant_user.name
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}
