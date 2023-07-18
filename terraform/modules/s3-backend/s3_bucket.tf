resource "aws_s3_bucket" "terraform-state-backend-s3-bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "terraform-state-backend-s3-bucket-versioning" {
  bucket = aws_s3_bucket.terraform-state-backend-s3-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-state-backend-s3-bucket-sse" {
  bucket = aws_s3_bucket.terraform-state-backend-s3-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "terraform-state-backend-s3-bucket-public-access-block" {
  bucket = aws_s3_bucket.terraform-state-backend-s3-bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}