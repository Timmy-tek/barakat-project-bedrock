resource "aws_iam_user" "bedrock_dev_view" {
  name = "bedrock-dev-view"

  tags = {
    Project = "barakat-2025-capstone"
  }
}

# This block actually generates the Access Key and Secret
resource "aws_iam_access_key" "developer_key" {
  user = aws_iam_user.bedrock_dev_view.name
}

resource "aws_iam_user_policy_attachment" "developer_readonly" {
  user       = aws_iam_user.bedrock_dev_view.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}