# Existing password generator
resource "random_password" "sql_password" {
  length           = 16
  special          = true
  upper            = true
  lower            = true
  numeric          = true
  override_special = "!#%^*_+=-"
}

######################################
# Store DB credentials in Secrets Manager
######################################

# Create the secret container
resource "aws_secretsmanager_secret" "db_secret" {
  name        = "${var.db_identifier}-db-credentials"
  description = "RDS DB credentials (username, password, endpoint) for ${var.db_identifier}"
}

# Store username, password, and endpoint in JSON format
resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.sql_password.result
    endpoint = aws_db_instance.db.address
  })
  depends_on = [aws_db_instance.db]
}

######################################
# RDS Instance
######################################

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
  publicly_accessible    = var.publicly_accessible
  storage_encrypted      = var.storage_encrypted
  license_model          = var.license_model
  kms_key_id             = var.kms_key_arn
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