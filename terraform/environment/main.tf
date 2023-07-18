terraform {
  required_version = ">= 1.1"

  backend "s3" {
    key            = "development.tfstate"
    region         = "us-east-1"
    bucket         = "lambda-rds-terraform-state-backend"
    encrypt        = true
    dynamodb_table = "lambda-rds-terraform-state-lock-dynamodb"
  }

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
