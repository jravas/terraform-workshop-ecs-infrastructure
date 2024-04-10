resource "random_password" "rds_password" {
  length  = 16
  special = false
}

resource "aws_db_subnet_group" "rds" {
  name       = "${var.db_server_name}-db"
  subnet_ids = var.subnets

  tags = {
    Name        = "${var.db_server_name}-db"
    Environment = var.environment
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.db_server_name}-db"
  vpc_id      = data.aws_vpc.current.id
  description = "Allow inbound traffic from the internet to the database server"

  ingress {
    protocol    = "tcp"
    from_port   = local.db_server_port
    to_port     = local.db_server_port
    cidr_blocks = var.allowed_address_groups
  }

  tags = {
    Name        = "${var.db_server_name}-db"
    Environment = var.environment
  }
}

resource "aws_db_instance" "primary" {
  identifier     = var.db_server_name
  engine         = var.db_server_type
  engine_version = var.db_server_version
  instance_class = var.db_instance_class

  username = local.rds_username
  password = local.rds_password
  db_name  = local.rds_username

  backup_retention_period = 14
  backup_window           = "03:00-03:30"

  multi_az = var.is_multi_az

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.allocated_storage * 2

  publicly_accessible          = var.is_publicly_accessible
  performance_insights_enabled = local.performance_insights_enabled
  skip_final_snapshot          = true

  db_subnet_group_name = aws_db_subnet_group.rds.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]
}

