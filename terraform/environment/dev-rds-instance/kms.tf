data "aws_kms_key" "rds_default" {
  key_id = "alias/aws/rds"
}
