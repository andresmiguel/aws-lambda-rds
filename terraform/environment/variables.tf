variable "aws_config_profile" {
  default     = "default"
  description = "Name of the AWS SDK/CLI configuration profile"
  type        = string
}

variable "sam_s3_bucket_expiration_days" {
  default     = 7
  description = "Number of days to expire objects in the SAM S3 bucket"
  type        = number
}

variable "db_apply_immediately" {
  description = "Whether the DB config change should be applied immediately"
  type        = bool
  default     = false
}

variable "bastion_host_key_name" {
  description = "Key name to associate the EC2 Bastion Host with"
  type        = string
}