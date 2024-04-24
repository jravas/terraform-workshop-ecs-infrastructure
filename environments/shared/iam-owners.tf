// Terraform user's access key/secret will be used for provisioning all resources and users.
module "terraform_user" {
  source               = "../../modules/iam-user"
  name                 = "terraform"
  allow_console_access = false
}

module "vlatko_vlahek_user" {
  source               = "../../modules/iam-user"
  name                 = "vlatko.vlahek"
  allow_console_access = true
}

module "josip_ravas_user" {
  source               = "../../modules/iam-user"
  name                 = "josip.ravas"
  allow_console_access = true
}

module "owners_user_group" {
  source      = "../../modules/iam-user-group"
  name        = "owners"
  policy_arns = [module.superadmin_policy.arn]

  members = [
    module.terraform_user.user_name,
    module.vlatko_vlahek_user.user_name,
    module.josip_ravas_user.user_name,
  ]
}

