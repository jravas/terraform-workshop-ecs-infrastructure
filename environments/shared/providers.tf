provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_access_secret
}

provider "aws" {
  alias      = "global"
  region     = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_access_secret
}
