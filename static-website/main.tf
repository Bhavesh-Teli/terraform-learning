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
  bucket = "my-webapp-${random_id.ran_id.hex}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "example" {
   bucket = aws_s3_bucket.tf_bucket_abc.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "my_webapp_policy" {
  bucket = aws_s3_bucket.tf_bucket_abc.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.tf_bucket_abc.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "my_webapp" {
  bucket = aws_s3_bucket.tf_bucket_abc.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}
resource "aws_s3_object" "bucket_data" {
  bucket = aws_s3_bucket.tf_bucket_abc.bucket
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

output "name" {
#   value = random_id.ran_id.hex
value = aws_s3_bucket.tf_bucket_abc.website_endpoint
}
