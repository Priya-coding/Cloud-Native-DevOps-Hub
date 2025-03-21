# ------------------------------------------------------------------------------
# IAM Module Outputs
# Provides outputs for IAM roles and policies.
# ------------------------------------------------------------------------------

output "eks_cluster_role_arn" {
  description = "IAM Role ARN for EKS Cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "IAM Role ARN for EKS Worker Nodes"
  value       = aws_iam_role.eks_node_role.arn
}

output "s3_access_role_arn" {
  description = "IAM Role ARN for S3 Access"
  value       = aws_iam_role.s3_access_role.arn
}

output "rds_access_role_arn" {
  description = "IAM Role ARN for RDS Access"
  value       = aws_iam_role.rds_access_role.arn
}
