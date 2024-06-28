# Create S3 Bucket

resource "aws_s3_bucket" "donfolayan_bucket" {
  bucket = var.bucket-name
}

# Setup Default Policies

resource "aws_s3_bucket_website_configuration" "donfolayan_bucket" {
  bucket = aws_s3_bucket.donfolayan_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Create a bucket policy
resource "aws_s3_bucket_public_access_block" "donfolayan_bucket_public_access_block" {
    bucket = aws_s3_bucket.donfolayan_bucket.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

# Manage IAM Policy so anybody can GetObject

data "aws_iam_policy_document" "donfolayan_bucket_policy_document" {
  statement {
    principals {
      type = "*"
      identifiers = ["*"]
    }
    actions = ["s3:GetObject"]
    effect  = "Allow"
    resources = [
      "${aws_s3_bucket.donfolayan_bucket.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.donfolayan_bucket.id
  policy = data.aws_iam_policy_document.donfolayan_bucket_policy_document.json
}

resource "aws_s3_object" "provision_source_files" {
    bucket  = aws_s3_bucket.donfolayan_bucket.id
    
    for_each = fileset("Config/Website", "**/*.*") 
    
    key    = each.value
    source = "Config/website/${each.value}"
    content_type = each.value
}