locals {
  aws_sam_cli_src_bucket = lower("aws-sam-cli-managed-source-s3-bucket-lambda-rds-${random_string.random_string.result}")
  ssm_parameters         = {
    "/lambda-rds/db-resource-id" : "String",
    "/lambda-rds/db-iam-user" : "String",
    "/lambda-rds/db-name" : "String",
    "/lambda-rds/db-endpoint" : "String",
    "/lambda-rds/subnet-ids" : "StringList",
    "/lambda-rds/security-groups" : "StringList",
  }
}

resource "random_string" "random_string" {
  length  = 8
  special = false
}
