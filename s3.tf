resource "aws_s3_bucket" "one" {
  bucket = "rakeshsunnu.rs"
}

resource "aws_s3_bucket_ownership_controls" "two" {
  bucket = aws_s3_bucket.one.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "three" {
  depends_on = [aws_s3_bucket_ownership_controls.two]

  bucket = aws_s3_bucket.one.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "three" {
bucket = aws_s3_bucket.one.id
versioning_configuration {
status = "Enabled"
}
}

#AFTER CREATING S3 BUCKET REMOOVE THESE HASHTAGS
#terraform {
#backend "s3" {
#region = "us-east-1"
#bucket = "mustafashaik77.devops.project.bucket"
#key = "prod/terraform.tfstate"
#}
#}
