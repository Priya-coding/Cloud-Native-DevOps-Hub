# ------------------------------------------------------------------------------
# RDS Module Outputs
# Provides outputs for database connectivity and credentials.
# ------------------------------------------------------------------------------

output "rds_endpoint" {
  description = "RDS Database endpoint"
  value       = aws_db_instance.postgres_db.endpoint
}

output "rds_port" {
  description = "RDS Database port"
  value       = aws_db_instance.postgres_db.port
}

output "rds_security_group_id" {
  description = "Security group ID for the RDS instance"
  value       = aws_security_group.rds_sg.id
}

output "rds_secrets_manager_arn" {
  description = "ARN of the stored database credentials in AWS Secrets Manager"
  value       = aws_secretsmanager_secret.rds_secret.arn
}
