variable "subnet_id" {
  description = "Id of the subnet to deploy the EC2 instance into"
  type        = string
}

variable "security_group_ids" {
  description = "Security group ids to apply to the EC2 instance"
  type        = set(string)
}

variable "key_name" {
  description = "Key name to associate the EC2 instance with"
  type        = string
}