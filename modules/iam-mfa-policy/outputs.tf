output "arn" {
  description = "AWS IAM MFA Policy unique identifier."
  value       = aws_iam_policy.mfa.arn
}
