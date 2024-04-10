resource "aws_iam_user" "this" {
  name = var.name
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_user_login_profile" "dashboard" {
  count = var.allow_console_access ? 1 : 0

  user = aws_iam_user.this.name

  // Fix for issue with password reset by user recreating user: https://github.com/hashicorp/terraform-provider-aws/issues/23567
  password_reset_required = true
  lifecycle {
    ignore_changes = [password_reset_required]
  }
}
