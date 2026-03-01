resource "aws_s3_bucket" "assets" {
  bucket = "bedrock-assets-alt-soe-025-0157"
  acl    = "private"

  tags = {
    Project = "barakat-2025-capstone"
  }
}

# Optional: Block all public access (best practice)
resource "aws_s3_bucket_public_access_block" "assets_block" {
  bucket                  = aws_s3_bucket.assets.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#To Grant developer PutObject Access
resource "aws_iam_policy" "dev_s3_put" {
  name        = "bedrock-assets-putpolicy"
  description = "Allow PutObject to S3 assets bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:PutObject"]
        Resource = "${aws_s3_bucket.assets.arn}/*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "dev_put_attach" {
  user       = aws_iam_user.bedrock_dev_view.name
  policy_arn = aws_iam_policy.dev_s3_put.arn
}