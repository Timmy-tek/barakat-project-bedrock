output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "region" {
  value = "us-east-1"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "developer_access_key_id" {
  value = aws_iam_access_key.developer_key.id
}

output "developer_secret_access_key" {
  value     = aws_iam_access_key.developer_key.secret
  sensitive = true
}

output "assets_bucket_name" {
  value = aws_s3_bucket.assets.id
}