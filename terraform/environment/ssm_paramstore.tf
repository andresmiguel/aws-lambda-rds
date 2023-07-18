resource "aws_ssm_parameter" "ssm-parameters" {
  for_each = local.ssm_parameters

  name  = each.key
  type  = each.value
  value = "<ThisValueMustBeChanged>"

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}


