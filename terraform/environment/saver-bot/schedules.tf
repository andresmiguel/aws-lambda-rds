resource "aws_scheduler_schedule_group" "lambda-rds-dev" {
  name = "lambda-rds-dev"
}

resource "aws_scheduler_schedule" "stop-rds-schedule" {
  name       = "lambda-rds-dev-saverbot-stop-rds-instance"
  group_name = aws_scheduler_schedule_group.lambda-rds-dev.name

  flexible_time_window {
    mode = "OFF"
  }

  // every Friday at 23:00 UTC
  schedule_expression = "cron(0 23 ? * FRI *)"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:rds:stopDBInstance"
    role_arn = aws_iam_role.saverbot-role.arn

    input = jsonencode({
      DbInstanceIdentifier = var.rds_instance_identifier
    })
  }
}

resource "aws_scheduler_schedule" "start-rds-schedule" {
  name       = "lambda-rds-dev-saverbot-start-rds-instance"
  group_name = aws_scheduler_schedule_group.lambda-rds-dev.name

  flexible_time_window {
    mode = "OFF"
  }

  // every Monday at 12:00 UTC
  schedule_expression = "cron(0 12 ? * MON *)"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:rds:startDBInstance"
    role_arn = aws_iam_role.saverbot-role.arn

    input = jsonencode({
      DbInstanceIdentifier = var.rds_instance_identifier
    })
  }
}

resource "aws_scheduler_schedule" "stop-ec2-schedule" {
  name       = "lambda-rds-dev-saverbot-stop-ec2-instance"
  group_name = aws_scheduler_schedule_group.lambda-rds-dev.name

  flexible_time_window {
    mode = "OFF"
  }

  // every Friday at 23:00 UTC
  schedule_expression = "cron(0 23 ? * FRI *)"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = aws_iam_role.saverbot-role.arn

    input = jsonencode({
      InstanceIds = [
        var.ec2_instance_id
      ]
    })
  }
}

resource "aws_scheduler_schedule" "start-ec2-schedule" {
  name       = "lambda-rds-dev-saverbot-start-ec2-instance"
  group_name = aws_scheduler_schedule_group.lambda-rds-dev.name

  flexible_time_window {
    mode = "OFF"
  }

  // every Monday at 12:00 UTC
  schedule_expression = "cron(0 12 ? * MON *)"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:startInstances"
    role_arn = aws_iam_role.saverbot-role.arn

    input = jsonencode({
      InstanceIds = [
        var.ec2_instance_id
      ]
    })
  }
}