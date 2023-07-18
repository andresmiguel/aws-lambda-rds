#!/bin/bash

prop_file_name=rds-ssh-tunnel.properties

get_prop() {
  str="$(grep "$1" < "$prop_file_name")"
  IFS="=" read -ra values <<< "$str"
  second_value="${values[1]}"
  trimmed_string="${second_value#"${second_value%%[![:space:]]*}"}"
  trimmed_string="${trimmed_string%"${trimmed_string##*[![:space:]]}"}"
  trimmed_string=${trimmed_string//\"}
  echo "$trimmed_string"
}

ec2_instance_id=$(get_prop ec2_instance_id)
rds_endpoint=$(get_prop rds_endpoint)
priv_key_file=$1
db_local_port=${2:-5432}

if [[ -z "$priv_key_file" ]]
then
  echo "You must provide the PEM file location as the first script argument!" && exit 1
fi

echo "Using private key file: $priv_key_file"

ec2_ip=$(aws ec2 describe-instances \
--filters \
"Name=instance-state-name,Values=running" \
"Name=instance-id,Values=${ec2_instance_id}" \
--query 'Reservations[*].Instances[*].[PublicIpAddress]' \
--output text)

echo "Opening SSH tunnel to: $rds_endpoint"
echo "Through: $ec2_ip"
echo "Using local port: $db_local_port"

ssh -i "$priv_key_file" -L"$db_local_port":"$rds_endpoint":5432 ec2-user@"$ec2_ip" -N
