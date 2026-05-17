variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "tenant_name" {
  description = "The name of the tenant"
  type        = string
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "shared-gke-cluster"
}

variable "db_password" {
  description = "The database password generated in Task 1"
  type        = string
  sensitive   = true
}
