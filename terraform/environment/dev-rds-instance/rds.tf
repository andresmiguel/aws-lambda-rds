data "aws_subnet" "first_subnet" {
  id = var.db_subnet_ids[0]
}

resource "aws_db_subnet_group" "postgres-db-subnet-group" {
  name       = "lambda-rds-dev-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "lambda-rds-dev-subnet-group"
  }
}
#tfsec:ignore:aws-rds-specify-backup-retention
#tfsec:ignore:AVD-AWS-0177
resource "aws_db_instance" "postgres-db" {
  identifier             = "lambda-rds-dev"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15.2"
  instance_class         = "db.t4g.small"
  storage_type           = "gp2"
  parameter_group_name   = "default.postgres15"
  port                   = 5432
  db_subnet_group_name   = aws_db_subnet_group.postgres-db-subnet-group.name
  vpc_security_group_ids = var.security_group_ids
  kms_key_id             = data.aws_kms_key.rds_default.arn
  availability_zone      = data.aws_subnet.first_subnet.availability_zone
  storage_encrypted      = true
  skip_final_snapshot    = true
  apply_immediately      = var.apply_immediately

  iam_database_authentication_enabled = true
  username                            = "postgres"
  password                            = "this_is_a_dummy_password"
}
