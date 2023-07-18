variable "db_subnet_ids" {
  description = "Ids of the subnets to deploy the DB cluster into"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group ids to apply to the DB cluster"
  type        = set(string)
}

variable "apply_immediately" {
  description = "Whether the DB config change should be applied immediately"
  type        = bool
  default     = false
}