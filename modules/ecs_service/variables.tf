variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}
variable "task_cpu" {
  description = "The number of CPU units to reserve for the container"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "The amount of memory (in MiB) to reserve for the container"
  type        = number
  default     = 512
}

variable "container_image" {
  description = "The image of the container"
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task to place and keep running"
  type        = number
  default     = 1
}

variable "service_subnets" {
  description = "The subnets to place the ECS service in"
  type        = list(string)
}

variable "service_security_groups" {
  description = "The security groups to place the ECS service in"
  type        = list(string)
}

variable "service_assign_public_ip" {
  description = "Whether to assign a public IP address to the ECS service"
  type        = bool
  default     = true
}

variable "task_name" {
  description = "The name of the ECS task, service and family"
  type        = string
  default     = "default-task"
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
  default     = 80
}

variable "host_port" {
  description = "The port on which the host listens"
  type        = number
  default     = 80
}

# variable that is array of objects
variable "environment" {
  description = "The environment variables to pass to the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}


variable "target_group_arn" {
  description = "The ARN of the target group to associate with the ECS service"
  type        = string
  default     = ""
}
