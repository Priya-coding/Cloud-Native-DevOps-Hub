# Global Outputs for Terraform Modules

output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value       = module.eks.eks_cluster_id
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster API endpoint"
  value       = module.eks.eks_cluster_endpoint
}

output "rds_endpoint" {
  description = "RDS Database endpoint"
  value       = module.rds.rds_endpoint
}

output "s3_bucket_name" {
  description = "S3 Bucket name"
  value       = module.s3.s3_bucket_name
}
