# Terraform Block: Defines the required Terraform provider
terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider: Configures Terraform to use AWS Free Tier resources
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile # AWS CLI Profile for authentication
}