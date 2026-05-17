resource "google_sql_database" "tenant_db" {
  name     = "${var.tenant_name}-db"
  instance = var.instance_name
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "google_sql_user" "tenant_user" {
  name     = "${var.tenant_name}-user"
  instance = var.instance_name
  password = random_password.db_password.result
}
