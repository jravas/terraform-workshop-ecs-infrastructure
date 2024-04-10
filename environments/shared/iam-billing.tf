module "billing_group" {
  source      = "../../modules/iam-user-group"
  name        = "billing"
  policy_arns = [data.aws_iam_policy.billing.arn]

  members = [
    module.vlatko_vlahek_user.user_name,
    module.josip_ravas_user.user_name,
  ]
}
