variable "name" {
  description = "User group name."
  type        = string
}

variable "policy_arns" {
  description = "IAM policy ARN List."
  type        = list(string)
}

variable "members" {
  description = "List of user names which will be assigned to this group."
  type        = list(string)
}
