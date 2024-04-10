variable "vpc_id" {
  description = "Virtual Private Circle ID"
  type        = string
}

variable "db_server_name" {
  description = "RDS instance name."
  type        = string
}

variable "db_server_type" {
  description = "RDS instance type."
  type        = string
}

variable "db_server_version" {
  description = "RDS instance version."
  type        = string
}

variable "db_instance_class" {
  description = "RDS Instance class"
  type        = string
}

variable "allocated_storage" {
  description = "RDS Instance allocated storage"
  type        = number
}

variable "is_publicly_accessible" {
  description = "Enables or disables database public access. This is a security flag."
  type        = bool
}

variable "is_multi_az" {
  description = "Enables or disables multi az availability."
  type        = bool
}

variable "allowed_address_groups" {
  description = "Allowed CIDR groups"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets to attach the database to."
  type        = list(string)
}

variable "environment" {
  description = "Environment."
  type        = string

  validation {
    condition     = contains(["development", "production"], var.environment)
    error_message = "Allowed values for environment are development or production."
  }
}
