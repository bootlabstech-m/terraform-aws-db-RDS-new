resource "random_string" "sql_server_suffix" {
  length  = 4
  special = false
  upper   = false
  lower   = true
  numeric  = true
}
resource "random_password" "sql_password" {
  length           = 16
  special          = true
  upper            = true
  lower            = true
  numeric          = true
  override_special = "!#%^*_+=-"
}

resource "aws_db_instance" "db" {
  identifier             = var.db_identifier
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  db_name                = var.name
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  username               = var.db_username
  password               = random_password.sql_password.result
  parameter_group_name   = var.parameter_group_name
  skip_final_snapshot    = var.skip_final_snapshot
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids = var.vpc_security_group_ids
  snapshot_identifier    = var.snapshot_identifier
  publicly_accessible    = false
  storage_encrypted           = true
  license_model = var.license_model
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
  lifecycle {
    ignore_changes = [tags]
  }
}