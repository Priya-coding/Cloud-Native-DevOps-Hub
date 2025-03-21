# ------------------------------------------------------------------------------
# IAM Module Variables
# Defines configurable parameters for IAM roles and policies.
# ------------------------------------------------------------------------------

variable "eks_cluster_role_name" {
  description = "Name of the IAM role for EKS Cluster"
  type        = string
  default     = "eks-cluster-role"
}

variable "eks_node_role_name" {
  description = "Name of the IAM role for EKS Worker Nodes"
  type        = string
  default     = "eks-node-role"
}

variable "s3_access_role_name" {
  description = "Name of the IAM role for accessing S3"
  type        = string
  default     = "s3-access-role"
}

variable "rds_access_role_name" {
  description = "Name of the IAM role for accessing RDS"
  type        = string
  default     = "rds-access-role"
}
