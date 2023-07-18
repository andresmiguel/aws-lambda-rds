output "ipv4" {
  description = "IPv4 of the instance"
  value       = aws_instance.bastion-host.public_ip
}

output "instance_id" {
  description = "Id of the instance"
  value       = aws_instance.bastion-host.id
}

output "instance_arn" {
  description = "ARN of the instance"
  value       = aws_instance.bastion-host.arn
}