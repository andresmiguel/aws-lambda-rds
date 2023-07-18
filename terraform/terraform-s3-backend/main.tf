terraform {
  required_version = ">= 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "~> 5.0",
    }
  }
}

provider "aws" {
  profile = var.aws_config_profile
  region  = "us-east-1"
  default_tags {
    tags = {
      project = "lambda-rds"
      owner   = "Andres Bores"
    }
  }
}

module "s3-backend" {
  source = "../modules/s3-backend"

  bucket_name         = "lambda-rds-terraform-state-backend"
  dynamodb_table_name = "lambda-rds-terraform-state-lock-dynamodb"
}