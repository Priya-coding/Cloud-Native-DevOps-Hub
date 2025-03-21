# Root Terraform File - Calls Modules for Infrastructure Setup

module "eks" {
  source          = "./modules/eks"
  eks_cluster_name = var.eks_cluster_name
  subnet_ids      = var.subnet_ids
}

module "iam" {
  source = "./modules/iam"
}

module "rds" {
  source           = "./modules/rds"
  db_name         = var.db_name
  db_instance_class = var.db_instance_class
  db_username      = var.db_username
  db_password      = var.db_password
}

module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
}
