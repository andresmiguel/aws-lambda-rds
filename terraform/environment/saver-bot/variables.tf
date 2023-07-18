variable "rds_instance_arn" {
  description = "ARN of the RDS DB instance"
  type        = string
}

variable "rds_instance_identifier" {
  description = "Identifier of the RDS DB instance"
  type        = string
}

variable "ec2_instance_arn" {
  description = "ARN of the EC2 instance"
  type        = string
}

variable "ec2_instance_id" {
  description = "Id of the EC2 instance"
  type        = string
}