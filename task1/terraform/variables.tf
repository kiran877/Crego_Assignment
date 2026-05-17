variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "instance_name" {
  description = "The name of the existing Cloud SQL instance"
  type        = string
}

variable "tenant_name" {
  description = "The name of the tenant"
  type        = string
}
