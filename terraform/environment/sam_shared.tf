#tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "sam-cli-src-s3-bucket" {
  bucket = local.aws_sam_cli_src_bucket
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-state-backend-s3-bucket-sse" {
  bucket = aws_s3_bucket.sam-cli-src-s3-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "terraform-state-backend-s3-bucket-public-access-block" {
  bucket = aws_s3_bucket.sam-cli-src-s3-bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "sam-cli-src-s3-bucket-lifecycle-config" {
  bucket = aws_s3_bucket.sam-cli-src-s3-bucket.id

  rule {
    id = "delete-old"

    filter {}

    expiration {
      days = var.sam_s3_bucket_expiration_days
    }

    status = "Enabled"
  }
}