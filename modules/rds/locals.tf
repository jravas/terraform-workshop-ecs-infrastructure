locals {
  db_server_port               = 5432
  rds_username                 = replace(var.db_server_name, "-", "_")
  rds_password                 = random_password.rds_password.result
  server_type_segments         = split(".", var.db_instance_class)
  performance_insights_enabled = true
}
