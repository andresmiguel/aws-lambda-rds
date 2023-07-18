resource "aws_iam_role" "saverbot-role" {
  name               = "lambda-rds-dev-saverbot-role"
  assume_role_policy = data.aws_iam_policy_document.saverbot-assume-role-policy.json
}

data "aws_iam_policy_document" "saverbot-assume-role-policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = [
        "scheduler.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy" "saverbot-policy" {
  name   = "saverbot"
  role   = aws_iam_role.saverbot-role.id
  policy = data.aws_iam_policy_document.saverbot-policy-document.json
}

data "aws_iam_policy_document" "saverbot-policy-document" {
  statement {
    actions = [
      "rds:StopDBInstance",
      "rds:StartDBInstance",
      "ec2:StopInstances",
      "ec2:StartInstances",
    ]

    resources = [
      var.rds_instance_arn,
      var.ec2_instance_arn,
    ]
  }
}