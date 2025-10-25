terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.18.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "random_id" "ran_id" {
  byte_length = 8
  
}
resource "aws_s3_bucket" "tf_bucket_abc" {
  bucket = "tf-bucket-abc-${random_id.ran_id.hex}"
}

resource "aws_s3_object" "bucket_data" {
  bucket = aws_s3_bucket.tf_bucket_abc.bucket
  key    = "myFile .txt"
  source = "./myFile.txt"
}

output "name" {
  value = random_id.ran_id.hex
}
