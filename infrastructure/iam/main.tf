# ------------------------------------------------------------------------------
# IAM Module
# This module provisions IAM roles and policies for EKS and other AWS services.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# IAM Role for EKS Cluster
# This role allows Amazon EKS to manage AWS resources.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "eks_cluster_role" {
  name = var.eks_cluster_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
    }]
  })
}

# Attach EKS Cluster Policy
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# ------------------------------------------------------------------------------
# IAM Role for EKS Worker Nodes
# This role allows worker nodes to connect to the EKS cluster.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "eks_node_role" {
  name = var.eks_node_role_name

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

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# ------------------------------------------------------------------------------
# IAM Role for S3 Access
# This role grants access to an S3 bucket.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "s3_access_role" {
  name = var.s3_access_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_read_policy" {
  role       = aws_iam_role.s3_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# ------------------------------------------------------------------------------
# IAM Role for RDS Access
# This role grants access to Amazon RDS.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "rds_access_role" {
  name = var.rds_access_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "rds_policy" {
  role       = aws_iam_role.rds_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}
