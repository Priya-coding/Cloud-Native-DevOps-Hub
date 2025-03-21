# ------------------------------------------------------------------------------
# EKS Cluster Module
# This module provisions an Amazon EKS cluster with the necessary IAM roles 
# and permissions for secure and scalable Kubernetes deployment.
# ------------------------------------------------------------------------------

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [aws_iam_role_policy_attachment.eks_policy]
}

# ------------------------------------------------------------------------------
# IAM Role for EKS Cluster
# This IAM role allows EKS to manage AWS resources on your behalf.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
    }]
  })
}

# Attach Amazon EKS Cluster Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "eks_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

# ------------------------------------------------------------------------------
# EKS Node Group (Worker Nodes)
# This creates a managed node group for running Kubernetes workloads.
# ------------------------------------------------------------------------------

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn = aws_iam_role.eks_node_role.arn
  subnet_ids    = var.subnet_ids
  scaling_config {
    desired_size = var.node_desired_size
    min_size     = var.node_min_size
    max_size     = var.node_max_size
  }

  instance_types = ["t3.micro"] # Free-tier eligible instance
  disk_size      = 20

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy
  ]
}

# ------------------------------------------------------------------------------
# IAM Role for EKS Worker Nodes
# This IAM role allows worker nodes to connect to the EKS cluster.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# Attach policies to EKS Worker Node Role
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
