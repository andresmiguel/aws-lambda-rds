resource "aws_vpc" "dev-vpc" {
  cidr_block           = local.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "lambda-rds-dev"
  }
}

/* Not allow ingress access in the default SG */
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.dev-vpc.id

  egress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 0
    protocol  = -1
    to_port   = 0
  }

}

/* Manage default NACL
   Allow ingress and egress access */
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.dev-vpc.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  lifecycle {
    ignore_changes = [subnet_ids]
  }

  tags = {
    Name = "lambda-rds-dev-default-nacl"
  }
}