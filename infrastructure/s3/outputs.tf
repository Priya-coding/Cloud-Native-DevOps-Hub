# ------------------------------------------------------------------------------
# S3 Module Outputs
# Provides outputs for the created S3 bucket.
# ------------------------------------------------------------------------------

output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.logs_bucket.id
}

output "s3_bucket_arn" {
  description = "The ARN of the created S3 bucket"
  value       = aws_s3_bucket.logs_bucket.arn
}
