variable "aws_config_profile" {
  default     = "default"
  description = "Name of the AWS SDK/CLI configuration profile"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket that is going to store the state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDb table state locking"
  type        = string
}
