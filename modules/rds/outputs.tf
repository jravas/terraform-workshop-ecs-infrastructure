output "rds_address" {
  description = "RDS instance address."
  value       = aws_db_instance.primary.address
}

output "rds_endpoint" {
  description = "RDS instance endpoint."
  value       = aws_db_instance.primary.endpoint
}

output "rds_username" {
  description = "RDS instance superuser username."
  value       = aws_db_instance.primary.username
}

output "rds_password" {
  description = "RDS instance superuser password."
  value       = aws_db_instance.primary.password
}

output "rds_port" {
  description = "RDS instance superuser password."
  value       = tostring(aws_db_instance.primary.port)
}
