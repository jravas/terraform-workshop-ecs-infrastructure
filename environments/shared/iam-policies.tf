module "superadmin_policy" {
  source = "../../modules/iam-superadmin-policy"
}

module "mfa_policy" {
  source = "../../modules/iam-mfa-policy"
}
