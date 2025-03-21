# ------------------------------------------------------------------------------
# EKS Module Outputs
# Provides outputs for other modules or external use.
# ------------------------------------------------------------------------------

output "eks_cluster_id" {
  description = "ID of the created EKS cluster"
  value       = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster API endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_node_group_name" {
  description = "Name of the EKS node group"
  value       = aws_eks_node_group.eks_nodes.node_group_name
}
