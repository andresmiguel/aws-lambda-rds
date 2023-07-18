#!/bin/bash

get_prop() {
  str="$(grep "$1" <<< "$terraform_output")"
  IFS="=" read -ra values <<< "$str"
  second_value="${values[1]}"
  trimmed_string="${second_value#"${second_value%%[![:space:]]*}"}"
  trimmed_string="${trimmed_string%"${trimmed_string##*[![:space:]]}"}"
  trimmed_string=${trimmed_string//\"}
  echo "$trimmed_string"
}

set_ssm_param() {
  type=${3:-String}

  aws ssm put-parameter \
    --name "$1" \
    --value "$2" \
    --type "$type" \
    --overwrite > /dev/null
}

echo "Getting Terraform output..."
terraform_output=$(terraform output)

if [[ $? -ne 0 || $terraform_output == *"Warning: "* ]]; then
  echo "$terraform_output"
  echo "There was a problem getting the Terraform output" && exit 1
fi

echo "Terraform output:"
echo "$terraform_output"
echo

db_instance_endpoint=$(get_prop db_instance_endpoint)
db_instance_resource_id=$(get_prop db_instance_resource_id)
lambda_functions_security_group_id=$(get_prop lambda_functions_security_group_id)
lambda_functions_subnet_id=$(get_prop lambda_functions_subnet_id)
db_iam_user="lambda_rds_db_user"
db_name="lambda_rds_test"

echo "Setting /lambda-rds/db-endpoint: $db_instance_endpoint"
set_ssm_param "/lambda-rds/db-endpoint" "$db_instance_endpoint"

echo "Setting /lambda-rds/db-iam-user: $db_iam_user"
set_ssm_param "/lambda-rds/db-iam-user" "$db_iam_user"

echo "Setting /lambda-rds/db-name: $db_name"
set_ssm_param "/lambda-rds/db-name" "$db_name"

echo "Setting /lambda-rds/db-resource-id: $db_instance_resource_id"
set_ssm_param "/lambda-rds/db-resource-id" "$db_instance_resource_id"

echo "Setting /lambda-rds/security-groups: $lambda_functions_security_group_id"
set_ssm_param "/lambda-rds/security-groups" "$lambda_functions_security_group_id" "StringList"

echo "Setting /lambda-rds/subnet-ids: $lambda_functions_subnet_id"
set_ssm_param "/lambda-rds/subnet-ids" "$lambda_functions_subnet_id" "StringList"
