resource "aws_iam_policy" "mfa" {
  name        = "AWSMfaManagement"
  description = "Allows the user to their own multifactor devices and their configuration."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "AllowViewAccountInfo",
        Effect   = "Allow",
        Action   = "iam:ListVirtualMFADevices",
        Resource = "*"
      },
      {
        Sid    = "AllowManageOwnVirtualMFADevice",
        Effect = "Allow",
        Action = [
          "iam:CreateVirtualMFADevice"
        ],
        Resource = "arn:aws:iam::*:mfa/*"
      },
      {
        Sid    = "AllowManageOwnUserMFA",
        Effect = "Allow",
        Action = [
          "iam:DeactivateMFADevice",
          "iam:EnableMFADevice",
          "iam:GetUser",
          "iam:ListMFADevices",
          "iam:ResyncMFADevice"
        ],
        Resource = "arn:aws:iam::*:user/$${aws:username}"
      },
      {
        Sid    = "DenyAllExceptListedIfNoMFA",
        Effect = "Deny",
        NotAction = [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:GetUser",
          "iam:ListMFADevices",
          "iam:ListVirtualMFADevices",
          "iam:ResyncMFADevice",
          "iam:ChangePassword",
          "iam:GetAccountPasswordPolicy",
          "sts:GetSessionToken",
        ],
        Resource = "*",
        Condition = {
          BoolIfExists = { "aws:MultiFactorAuthPresent" = "false" }
        }
      }
    ]
  })
}
