data "aws_iam_policy" "cognito_power_user" {
  name = "AmazonCognitoPowerUser"
}

data "aws_iam_policy" "ecr_power_user" {
  name = "AmazonElasticContainerRegistryPublicPowerUser"
}

data "aws_iam_policy" "s3_read_only_access" {
  name = "AmazonS3ReadOnlyAccess"
}

data "aws_iam_policy" "cloudfront_read_only_access" {
  name = "CloudFrontReadOnlyAccess"
}

data "aws_iam_policy" "acm_read_only_access" {
  name = "AWSCertificateManagerReadOnly"
}

data "aws_iam_policy" "beanstalk_read_only_access" {
  name = "AWSElasticBeanstalkReadOnly"
}

data "aws_iam_policy" "iam_allow_password_change" {
  name = "IAMUserChangePassword"
}

data "aws_iam_policy" "iam_allow_ssh_key_change" {
  name = "IAMUserSSHKeys"
}

data "aws_iam_policy" "iam_allow_service_account_change" {
  name = "IAMSelfManageServiceSpecificCredentials"
}

data "aws_iam_policy" "billing" {
  name = "Billing"
}

data "aws_iam_policy" "ec2_full_access" {
  name = "AmazonEC2FullAccess"
}
