resource "aws_instance" "bastion-host" {
  ami                    = data.aws_ami.amazon-linux-2023.id
  instance_type          = local.ec2_instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = {
    Name = "lambda-rds-dev-bastion-host"
  }
}