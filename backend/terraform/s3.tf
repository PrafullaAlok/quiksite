# Private bucket for data
resource "aws_s3_bucket" "data" {
  bucket = var.s3_private_bucket_name
  acl    = "private"
}

# Public bucket for backoffice
resource "aws_s3_bucket" "backoffice" {
  bucket = var.s3_bo_bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  versioning {
    enabled = true
  }

  policy = <<POLICY
{
"Version":"2012-10-17",
"Statement":[
  {
    "Sid":"AddPerm",
    "Effect":"Allow",
    "Principal": "*",
    "Action":["s3:GetObject"],
    "Resource":["arn:aws:s3:::${var.s3_bo_bucket_name}/*"]
  }
]
}
POLICY
}

# Public bucket for frontoffice
resource "aws_s3_bucket" "frontoffice" {
  bucket = var.s3_fo_bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  versioning {
    enabled = true
  }

  policy = <<POLICY
{
"Version":"2012-10-17",
"Statement":[
  {
    "Sid":"AddPerm",
    "Effect":"Allow",
    "Principal": "*",
    "Action":["s3:GetObject"],
    "Resource":["arn:aws:s3:::${var.s3_fo_bucket_name}/*"]
  }
]
}
POLICY
}
