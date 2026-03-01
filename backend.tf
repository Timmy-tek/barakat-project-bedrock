terraform {
  backend "s3" {
    bucket         = "bedrock-terraform-state-alt-soe-025-0157"
    key            = "project-bedrock/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "project-bedrock-lock-table"
    encrypt        = true
  }
}