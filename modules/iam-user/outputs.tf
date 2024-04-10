output "user_name" {
  description = "AWS IAM User Name."
  value       = aws_iam_user.this.name
}

output "user_arn" {
  description = "AWS IAM User ID."
  value       = aws_iam_user.this.arn
}

output "user_access_key" {
  description = "AWS IAM User Access Key."
  value       = aws_iam_access_key.this.id
  sensitive   = true
}

output "user_access_secret" {
  description = "AWS IAM User Access Secret."
  value       = aws_iam_access_key.this.secret
  sensitive   = true
}

output "initial_password" {
  value = var.allow_console_access ? aws_iam_user_login_profile.dashboard[0].password : null
}

# output "login_url" {
#   value = "https://${local.organization_alias}.signin.aws.amazon.com/console"
# }
