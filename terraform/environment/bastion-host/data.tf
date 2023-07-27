data "aws_ami" "amazon-linux-2023" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "block-device-mapping.volume-size"
    values = ["8"]
  }

  filter {
    name   = "ena-support"
    values = [true]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

