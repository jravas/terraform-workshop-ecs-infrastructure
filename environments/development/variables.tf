variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_access_secret" {
  description = "AWS Access Secret"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}
