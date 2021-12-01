resource "random_string" "random" {
  upper   = false
  length  = 16
  special = false
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "${random_string.random.id}.${var.aws_profile}.ethanzhang1997.me"
  acl           = var.s3_bucket_acl
  force_destroy = var.s3_bucket_force_destroy

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  tags = {
    Environment = var.aws_profile
  }
}

resource "aws_s3_bucket_public_access_block" "s3Public" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}