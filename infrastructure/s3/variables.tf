# ------------------------------------------------------------------------------
# S3 Module Variables
# Defines configurable parameters for the S3 bucket.
# ------------------------------------------------------------------------------

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "s3_force_destroy" {
  description = "Allow deletion of non-empty S3 bucket"
  type        = bool
  default     = false
}

variable "lifecycle_transition_days" {
  description = "Number of days before objects are transitioned to Glacier"
  type        = number
  default     = 30
}
