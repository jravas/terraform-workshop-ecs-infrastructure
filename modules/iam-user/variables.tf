variable "name" {
  description = "User name."
  type        = string
}

variable "allow_console_access" {
  description = "Determines whether this user should have AWS dashboard access enabled or not."
  type        = string
}
