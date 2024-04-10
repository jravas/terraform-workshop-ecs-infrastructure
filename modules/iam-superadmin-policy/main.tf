resource "aws_iam_policy" "superadmin" {
  name        = "AWSFullAccess"
  description = "Allows the user to manage all resources on this AWS account"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      },
    ]
  })
}
