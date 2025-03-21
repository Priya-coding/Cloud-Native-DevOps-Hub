# ------------------------------------------------------------------------------
# RDS Module Variables
# Defines configurable parameters for the RDS instance.
# ------------------------------------------------------------------------------

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_instance_class" {
  description = "Instance type for RDS (Free Tier Eligible: db.t3.micro)"
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "15.3"
}

variable "db_allocated_storage" {
  description = "Storage allocated to the RDS instance (Free Tier: 20GB)"
  type        = number
  default     = 20
}

variable "db_username" {
  description = "Database admin username"
  type        = string
}

variable "db_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "db_backup_retention" {
  description = "Number of days to retain database backups"
  type        = number
  default     = 7
}

variable "vpc_id" {
  description = "VPC ID where the RDS instance will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the database"
  type        = list(string)
  default     = ["10.0.0.0/16"] # Change this to your network range
}
