# ------------------------------------------------------------------------------
# S3 Bucket Module
# This module provisions an AWS S3 bucket for logs and artifact storage.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# S3 Bucket Creation
# Creates a private S3 bucket with versioning enabled.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "logs_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"
  force_destroy = var.s3_force_destroy
  tags = {
    Name = var.s3_bucket_name
    Environment = var.environment
  }
}

# ------------------------------------------------------------------------------
# Enable Versioning on the S3 Bucket
# Ensures that older versions of objects are retained for rollback.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket_versioning" "logs_versioning" {
  bucket = aws_s3_bucket.logs_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# ------------------------------------------------------------------------------
# Enable Server-Side Encryption
# Ensures data at rest is securely encrypted using AES256.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.logs_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# ------------------------------------------------------------------------------
# Public Access Block
# Ensures the bucket is **not** publicly accessible.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.logs_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ------------------------------------------------------------------------------
# S3 Lifecycle Policy (Optional)
# Moves objects to Glacier for long-term storage after 30 days.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_policy" {
  bucket = aws_s3_bucket.logs_bucket.id

  rule {
    id = "move-to-glacier"
    status = "Enabled"

    transition {
      days          = var.lifecycle_transition_days
      storage_class = "GLACIER"
    }
  }
}
