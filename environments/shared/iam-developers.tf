module "dino_stancic" {
  source               = "../../modules/iam-user"
  name                 = "dino.stancic"
  allow_console_access = true
}

module "prototyp_user_group" {
  source = "../../modules/iam-user-group"
  name   = "prototyp-developers"

  policy_arns = [
    data.aws_iam_policy.cognito_power_user.arn,
    data.aws_iam_policy.ecr_power_user.arn,
    data.aws_iam_policy.s3_read_only_access.arn,
    data.aws_iam_policy.cloudfront_read_only_access.arn,
    data.aws_iam_policy.acm_read_only_access.arn,
    data.aws_iam_policy.beanstalk_read_only_access.arn,
    data.aws_iam_policy.iam_allow_password_change.arn,
    data.aws_iam_policy.iam_allow_ssh_key_change.arn,
    data.aws_iam_policy.iam_allow_service_account_change.arn,
    module.mfa_policy.arn
  ]

  members = [
    module.dino_stancic.user_name,
  ]
}
