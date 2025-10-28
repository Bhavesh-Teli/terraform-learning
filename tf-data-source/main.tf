
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.18.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

data "aws_ami" "name" {
  most_recent = true
  owners      = ["amazon"]
}

output "aws_ami" {
  value = data.aws_ami.name.id
}

resource "aws_instance" "myserver" {
  ami           = data.aws_ami.name.id
  instance_type = "t3.micro"
  tags = {
    Name = "MyServer"
  }
}

data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

output "security_group" {
  value = data.aws_security_groups.default.ids
}

data "aws_vpcs" "name" {
    filter {
        name   = "isDefault"
        values = ["true"]
    }
}
output "vpc_id" {
  value = data.aws_vpcs.name.ids
}


data "aws_availability_zones" "names" {
    state = "available"
}

output "aws_zones" {
  value = data.aws_availability_zones.names
}

data "aws_caller_identity" "name" {}
output "caller_info" {
  value=data.aws_caller_identity.name
}