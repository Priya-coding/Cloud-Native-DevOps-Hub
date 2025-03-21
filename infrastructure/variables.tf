# Global Variables for Terraform Modules

variable "aws_region" {
  description = "AWS region for resource deployment"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile for authentication"
  default     = "default"
}

variable "eks_cluster_name" {
  description = "EKS Cluster name"
  default     = "cloud-devops-hub-eks"
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "db_name" {
  description = "Database name"
  default     = "cloud_devops_db"
}

variable "db_instance_class" {
  description = "RDS Database instance type"
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "Database admin username"
  default     = "admin"
}

variable "db_password" {
  description = "Database admin password"
  sensitive   = true
}

variable "s3_bucket_name" {
  description = "S3 Bucket name for logs"
  default     = "cloud-devops-hub-logs"
}
