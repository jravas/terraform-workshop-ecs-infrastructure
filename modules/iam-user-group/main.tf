resource "aws_iam_group" "this" {
  name = var.name
}

resource "aws_iam_group_policy_attachment" "this" {
  for_each = { for idx, policy_arn in var.policy_arns : idx => policy_arn }

  group      = aws_iam_group.this.name
  policy_arn = each.value
}

resource "aws_iam_group_membership" "this" {
  name  = aws_iam_group.this.name
  group = aws_iam_group.this.name
  users = var.members
}
