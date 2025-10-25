
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.18.0"
    }
  }
  backend "s3" {
    bucket = "tf-bucket-abc-45104355bf37a791"
    key    = "backend.tfstate"
    region = "ap-southeast-2"
  }
}



provider "aws" {
  region = var.region
}

resource "aws_instance" "tfserver" {
  ami           = "ami-0279a86684f669718"
  instance_type = "t3.micro"
  tags = {
    Name = "TerraformServer"
  }
}
