output "db_instance_arn" {
  description = "ARN of the RDS DB instance"
  value       = aws_db_instance.postgres-db.arn
}

output "db_instance_resource_id" {
  description = "Resource ID of the RDS DB instance"
  value       = aws_db_instance.postgres-db.id
}

output "db_instance_identifier" {
  description = "Identifier of the RDS DB instance"
  value       = aws_db_instance.postgres-db.identifier
}

output "db_instance_endpoint" {
  description = "Endpoint of the RDS DB instance"
  value       = split(":", aws_db_instance.postgres-db.endpoint)[0]
}

output "db_instance_port" {
  description = "Port of the RDS DB instance"
  value       = split(":", aws_db_instance.postgres-db.endpoint)[1]
}
