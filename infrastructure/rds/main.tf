# ------------------------------------------------------------------------------
# RDS Database Module
# This module provisions an AWS RDS PostgreSQL database instance.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# RDS Security Group
# Controls network access to the database.
# ------------------------------------------------------------------------------

resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-security-group"
  description = "Security group for RDS database"
  vpc_id      = var.vpc_id

  # Allow inbound traffic on PostgreSQL default port
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------------------------------------------------------------------
# AWS RDS PostgreSQL Instance
# Provisions a PostgreSQL database with Free Tier settings.
# ------------------------------------------------------------------------------

resource "aws_db_instance" "postgres_db" {
  identifier           = var.db_name
  engine              = "postgres"
  engine_version      = var.db_engine_version
  instance_class      = var.db_instance_class
  allocated_storage   = var.db_allocated_storage
  username            = var.db_username
  password            = var.db_password
  publicly_accessible = false
  storage_encrypted   = true
  backup_retention_period = var.db_backup_retention
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot = true
}

# ------------------------------------------------------------------------------
# RDS Subnet Group
# Defines which subnets the RDS instance will use.
# ------------------------------------------------------------------------------

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids
  description = "Subnet group for RDS database"
}

# ------------------------------------------------------------------------------
# AWS Secrets Manager (Optional)
# Stores database credentials securely.
# ------------------------------------------------------------------------------

resource "aws_secretsmanager_secret" "rds_secret" {
  name = "${var.db_name}-credentials"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    endpoint = aws_db_instance.postgres_db.endpoint
  })
}
