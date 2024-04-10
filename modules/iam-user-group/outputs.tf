output "group_arn" {
  description = "ARN of the AWS IAM User Group."
  value       = aws_iam_group.this.arn
}

output "group_name" {
  description = "Name of the AWS IAM User Group."
  value       = aws_iam_group.this.name
}
