output "bastion_host_public_ip" {
  description = "The public IPv4 of the Bastion Host"
  value       = module.bastion-host.ipv4
}

output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_port" {
  description = "The port of the RDS instance"
  value       = module.rds.db_instance_port
}

output "bastion_host_instance_id" {
  description = "The EC2 instance id of the Bastion Host"
  value       = module.bastion-host.instance_id
}

output "lambda_functions_security_group_id" {
  description = "The security group id of the Lambda Functions"
  value       = module.vpc.lambda_functions_security_group_id
}

output "lambda_functions_subnet_id" {
  description = "The subnet id of the Lambda Functions"
  value       = module.vpc.lambda_functions_subnet_id
}

output "sam_cli_source_s3_bucket_name" {
  description = "Name of the S3 bucket for the SAM source"
  value       = aws_s3_bucket.sam-cli-src-s3-bucket.bucket
}

output "db_instance_resource_id" {
  description = "Resource ID of the RDS DB instance"
  value       = module.rds.db_instance_resource_id
}
