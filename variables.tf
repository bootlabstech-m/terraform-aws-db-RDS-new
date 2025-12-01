variable "allocated_storage" {
  description = "The amount of allocated storage (in gigabytes) for the DB instance."
  type        = number
}

variable "name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
}

variable "db_engine" {
  description = "The database engine to use (e.g., mysql, postgres, oracle-se2)."
  type        = string
}

variable "db_engine_version" {
  description = "The version of the database engine to use."
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS DB (e.g., db.t3.micro, db.m5.large)."
  type        = string
}

variable "db_username" {
  description = "The master username for the DB instance."
  type        = string
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group to associate with this instance."
  type        = string
}

variable "skip_final_snapshot" {
  description = "Whether to skip taking a final DB snapshot before deletion (true/false)."
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role to associate with the DB instance (for enhanced monitoring or other integrations)."
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the DB instance."
  type        = string
  default     = "ap-south-1"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group."
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the DB instance."
  type        = list(string)
}

variable "snapshot_identifier" {
  description = "The identifier for the DB snapshot to restore from (if applicable)."
  type        = string
}

variable "publicly_accessible" {
  description = "Indicates whether the DB instance is publicly accessible (true/false)."
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Specifies whether the DB storage is encrypted (true/false)."
  type        = bool
  default     = true
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group to use for the DB instance."
  type        = string
}

variable "db_identifier" {
  description = "The unique identifier for the DB instance."
  type        = string
}

variable "storage_type" {
  description = "The storage type to use for the DB instance (e.g., gp2, io1, standard)."
  type        = string
}

variable "license_model" {
  description = "The license model for the DB instance (e.g., license-included, bring-your-own-license)."
  type        = string
  default     = "license-included"
}

variable "kms_key_alias" {
  type        = string
  description = "ARN of the existing Customer Managed KMS Key used to encrypt the RDS database storage"
  default     = "alias/mm_cmk_kms"
}
